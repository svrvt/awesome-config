import json
import os
import requests
import tempfile
from colorama import Fore, Style

# URL для загрузки JSON-файла
url = 'http://ipg.geospace.ru/services/current-space-weather.json'

# Функция для загрузки JSON-файла во временную директорию
def download_json(url):
    response = requests.get(url)
    response.raise_for_status()  # Проверка на ошибки при загрузке
    temp_file = tempfile.NamedTemporaryFile(delete=False, suffix='.json')
    with open(temp_file.name, 'w', encoding='utf-8') as file:
        json.dump(response.json(), file, ensure_ascii=False)
    return temp_file.name

# Чтение JSON-файла
json_file = download_json(url)

with open(json_file, 'r', encoding='utf-8') as file:
    data = json.load(file)

# Форматирование данных для виджета с цветовой сигнализацией
xray_description = data['xray']['description']
magnit_description = data['magnit']['description']
particles_description = data['particles']['description']

# Установка цветовой сигнализации на основе значений
if data['xray']['ball'] > 0:
    xray_output = f"{Fore.RED}X-Ray: {xray_description} ({data['xray']['ball']}){Style.RESET_ALL}"
else:
    xray_output = f"{Fore.GREEN}X-Ray: {xray_description} ({data['xray']['ball']}){Style.RESET_ALL}"

if data['magnit']['kp'] >= 4:
    magnit_output = f"{Fore.RED}Магнитное поле: {magnit_description} (Kp={data['magnit']['kp']}){Style.RESET_ALL}"
else:
    magnit_output = f"{Fore.YELLOW}Магнитное поле: {magnit_description} (Kp={data['magnit']['kp']}){Style.RESET_ALL}"

if data['particles']['ball'] > 0:
    particles_output = f"{Fore.RED}Частицы: {particles_description}{Style.RESET_ALL}"
else:
    particles_output = f"{Fore.GREEN}Частицы: {particles_description}{Style.RESET_ALL}"

# Вывод информации
print(xray_output)
print(magnit_output)
print(particles_output)

# Удаление временного файла (по желанию)
os.remove(json_file)

