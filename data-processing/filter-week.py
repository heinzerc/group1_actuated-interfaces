import json

toio_info = {"04/12/2020": {}}

with open('weather.json') as json_file:
    data = json.load(json_file)
    
for key in data.keys():
    date = key[0:10]
    time = key[11:]

    # convert to 24hr time
    if ("PM" in time and time != "12:00:00 PM"):
        time24 = int(time[0:2]) + 12
        time = str(time24) + ":00"
    elif (time == "12:00:00 AM"):
        time = "00:00"
    else:
        time = time[:5]

    # info we want to keep
    temp = data[key]['Air Temperature']
    temp = float(temp) * 1.8 + 32   # convert to Fahrenheit
    total_rain = data[key]['Total Rain']    
    total_rain = float(total_rain) # mm
    precipitation_type = int(data[key]['Precipitation Type'])   # 0 = none; 60 = liquid precipitation; 70 = solid precipitation

    if date not in toio_info:
        toio_info.update({date: {time: {'Air Temperature': temp, 'Total Rain': total_rain, 'Precipitation Type': precipitation_type}}})
    else:
        toio_info[date].update({time: {'Air Temperature': temp, 'Total Rain': total_rain, 'Precipitation Type': precipitation_type}})

# print(toio_info)

sorted_info = {}

# sort times 
for key in toio_info.keys():
    times = list(toio_info[key].keys())
    times.sort()
    sorted_times = {i: toio_info[key][i] for i in times}
    sorted_info.update({key: sorted_times})

with open('one-week-relevant-info.json', 'w', encoding='utf-8') as jsonf:
    jsonf.write(json.dumps(sorted_info, indent=4))