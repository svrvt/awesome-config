import json

# Чтение JSON-файла
with open('current-space-weather.json', 'r') as file:
    data = json.load(file)

# Форматирование данных для виджета
output = f"X-Ray: {data['xray']['description']} ({data['xray']['ball']})\n"
output += f"Магнитное поле: {data['magnit']['description']} (Kp={data['magnit']['kp']})\n"
output += f"Частицы: {data['particles']['description']}"

print(output)
