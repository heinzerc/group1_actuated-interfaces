import csv
import json

weatherData = {}

dates = ['04/12/2020', '04/13/2020', '04/14/2020', '04/15/2020', '04/16/2020', '04/17/2020', '04/18/2020']

with open('weather.csv', encoding='utf-8') as csvf:
    csvReader = csv.DictReader(csvf)

    for rows in csvReader:
        key = rows['Measurement Timestamp']
        for date in dates:
            if date in key:
                weatherData[key] = rows

with open('weather_weekof_02-12-2020.json', 'w', encoding='utf-8') as jsonf:
    jsonf.write(json.dumps(weatherData, indent=4))