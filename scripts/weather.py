#!/usr/bin/env python

from pyquery import PyQuery
import json

# weather icons
weather_icons = {
    "sunnyDay": "",
    "clearNight": "",
    "cloudyFoggyDay": "",
    "cloudyFoggyNight": "",
    "rainyDay": "",
    "rainyNight": "",
    "snowyIcyDay": "",
    "snowyIcyNight": "",
    "severe": "󰢘",
    "default": "",
}

location_id = "YOUR LOCATION ID HERE"
url = "https://weather.com/en-IN/weather/today/l/" + location_id
html_data = PyQuery(url=url)
temp = html_data("span[data-testid='TemperatureValue']").eq(0).text()
status = html_data("div[data-testid='wxPhrase']").text()
status = f"{status[:16]}.." if len(status) > 17 else status
status_code = html_data("#regionHeader").attr("class").split(" ")[2].split("-")[2]
icon = (
    weather_icons[status_code]
    if status_code in weather_icons
    else weather_icons["default"]
)
temp_feel = html_data(
    "div[data-testid='FeelsLikeSection'] > span > span[data-testid='TemperatureValue']"
).text()
temp_feel_text = f"Feels like {temp_feel}c"
temp_min = (
    html_data("div[data-testid='wxData'] > span[data-testid='TemperatureValue']")
    .eq(0)
    .text()
)
temp_max = (
    html_data("div[data-testid='wxData'] > span[data-testid='TemperatureValue']")
    .eq(1)
    .text()
)
temp_min_max = f"  {temp_min}\t\t  {temp_max}"
wind_speed = html_data("span[data-testid='Wind']").text().split("\n")[1]
wind_text = f"  {wind_speed}"
humidity = html_data("span[data-testid='PercentageValue']").text()
humidity_text = f"  {humidity}"
visbility = html_data("span[data-testid='VisibilityValue']").text()
visbility_text = f"  {visbility}"
air_quality_index = html_data("text[data-testid='DonutChartValue']").text()
prediction = html_data("section[aria-label='Hourly Forecast']")(
    "div[data-testid='SegmentPrecipPercentage'] > span"
).text()
prediction = prediction.replace("Chance of Rain", "")
prediction = f"\n\n    (hourly) {prediction}" if len(prediction) > 0 else prediction
tooltip_text = str.format(
    "\t\t{}\t\t\n{}\n{}\n{}\n\n{}\n{}\n{}{}",
    f'<span size="xx-large">{temp}</span>',
    f"<big>{icon}</big>",
    f"<big>{status}</big>",
    f"<small>{temp_feel_text}</small>",
    f"<big>{temp_min_max}</big>",
    f"{wind_text}\t{humidity_text}",
    f"{visbility_text}\tAQI {air_quality_index}",
    f"<i>{prediction}</i>",
)
out_data = {
    "text": f"{icon}   {temp}",
    "alt": status,
    "tooltip": tooltip_text,
    "class": status_code,
}
print(json.dumps(out_data))
