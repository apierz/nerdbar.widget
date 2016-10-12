command: "~/.kwm/scripts/compstatus"

refreshFrequency: 10000 # ms

render: (output) ->
  "<div class='compstatus'></div>
   <div class='weather_forecast'></div>"

style: """
  -webkit-font-smoothing: antialiased
  font: 12px Hack
  text-transform: lowercase
  right: 10px
  top: 6px
  color: #51afef
  .weather_forecast
    width: 8em
    background: #282c34
    top: 16px
    right: 100px
    opacity: 0
  .wifi
    font: 16px fontawesome
  .charging
    font: 12px fontawesome
    color: #FFFFFF
    position: relative
    font: 8px fontawesome
    top: -1px
    right: -11px
  .white
    color: #bbc2cf
  .green
    color: #98be65
  .yellow
    color: #ecbe7b
  .red
    color: #ff6c6b
  .icon
    font: 12px fontawesome
  .weather
    font: 12px WeatherIcons-Regular
  .blue
    color: #51afef
  .cyan
    color: #46d9ff
  .grey
    color: #dfdfdf
"""

timeAndDate: (date, time) ->
  return "<span class='white'><span class='icon'>&nbsp&nbsp&nbsp </span>#{date}</span>   <span class='icon'></span>#{time}</span>";

batteryStatus: (battery, state) ->
  batnum = parseInt(battery)
  console.log(state + " " + battery)
  
  if state == 'AC' and batnum >= 90
    return "<span class='charging'>  </span><span class='green'><span class='icon'>  </span>#{batnum}%</span>"
  else if state == 'AC' and batnum >= 50 and batnum < 90
    return "<span class='charging'>  </span><span class='green'><span class='icon'>  </span>#{batnum}%</span>"
  else if state == 'AC' and batnum < 50 and batnum >= 15
    return "<span class='charging'>  </span><span class='yellow'><span class='icon'>  </span>#{batnum}%</span>"
  else if state == 'AC' and batnum < 15
    return "<span class='charging'>  </span><span class='red'><span class='icon'>  </span>#{batnum}%</span>"
  else if state != 'AC' and batnum >= 90
    console.log('flag')
    return "<span class='green'><span class='icon'>  </span>#{batnum}%</span>"
  else if batnum >= 50 and batnum < 90
    return "<span class='green'><span class='icon'>  </span>#{batnum}%</span>"
  else if batnum < 50 and batnum >= 15
    return "<span class='yellow'><span class='icon'>  </span>#{batnum}%</span>"
  else if batnum < 15
    return "<span class='red'><span class='icon'>  </span>#{batnum}%</span>"

colorizeTemp: (temp) ->
  tempnum = parseInt(temp);
  if tempnum >= 90
    return "<span class='red'>#{temp}° </span>";
  if tempnum < 90 and tempnum >= 65
    return "<span class='yellow'>#{temp}° </span>";
  if tempnum < 65
    return "<span>#{temp}° </span>";

# Yahoo has horrible documentation for these codes, the ones on their website
# are incorrect so I'm slowly fixing these by trial and error.
# 
getWeatherIcon: (connum) ->
   # Tornados and Hurricanes
  if connum <= 2
    return "<span class='red weather'></span>" ;
  #Thunderstorms
  if connum > 2 and connum <= 4
    return "<span class='yellow weather'></span>" ;
  #Freezing Rain / Sleet
  if (connum >= 5 and connum <= 8) or connum == 10 or connum == 18
    return "<span class='blue weather'></span>" ;
  #Drizzle
  if connum == 9
    return "<span class='blue weather'></span>" ;
  #Rain
  if connum == 11 or connum == 12
    return "<span class='blue weather'></span>" ;
  #Snow
  if connum >= 13 and connum <= 16
    return "<span class='blue weather'></span>" ;
  #Hail
  if connum == 17
    return "<span class='blue weather'></span>" ;
  #Dust, fog, haze, etc
  if connum >= 19 and connum <= 22 
    return "<span class='cyan weather'></span>" ;
  # Windy
  if connum == 23 or connum == 24
    return "<span class='grey weather'></span>" ;
  #cold
  if connum == 25
    return "<span class='cyan weather'></span>" ;
  #cloudy
  if connum == 26
    return "<span class='cyan weather'></span>" ;
  #mostly cloudy (day) #fixed
  if connum == 27
    return "<span class='grey weather'></span>" ;
  #mostly cloudy (day)
  if connum == 28
    return "<span class='grey weather'></span>" ;
  #partly cloudy (day) #fixed
  if connum == 29
    return "<span class='grey weather'></span>" ;
  #partly cloudy (day)
  if connum == 30 #fixed
    return "<span class='grey weather'></span>" ;
  # clear night
  if connum == 31
    return "<span class='yellow weather'></span>" ;
  #Sunny
  if connum == 32
    return "<span class='yellow weather'></span>" ;
  #Fair, night
  if connum == 33
    return "<span class='yellow weather'></span>" ;
  #Mostly Sunny # Fixed
  if connum == 34
    return "<span class='yellow weather'></span>" ;
  # mixed rain and hail
  if connum == 35
    return "<span class='blue weather'></span>" ;
  #hot
  if connum == 36
    return "<span class='red weather'></span>" ;
  #thunder storms
  if connum >= 37 and connum < 39
    return "<span class='yellow weather'></span>" ;
  #scattered showers
  if connum >= 39 and connum <= 40 #fixed
    return "<span class='cyan weather'></span>" ;
  # snow
  if connum >= 41 and connum <=43
    return "<span class='cyan weather'></span>" ;
  #partly cloudy
  if connum == 44
    return "<span class='grey weather'></span>" ;
  #thunder showers
  if connum == 45
    return "<span class='cyan weather'></span>" ;
  #snow showers
  if connum == 46
    return "<span class='cyan weather'></span>" ;
  # isolated thundershowers
  if connum == 47
    return "<span class='yellow weather'></span>" ;

getWifiStatus: (connum) ->
  if connum isnt 99
    return "<span class='green wifi'>&nbsp&nbsp</span>";
  if connum is 99
    return "<span class='grey wifi'>&nbsp&nbsp</span>";

  


update: (output, domEl) ->

  values = output.split('@');
  time = values[0];
  date = values[1];
  battery = values[2];
  temp = values[3];
  condition = values[4];
  connum = parseInt(condition);
  batnum = parseInt(battery);

  # Five Day Forcast Parsing
  day0 = [values[5], values[6], values[7], values[8]]
  day1 = [values[9], values[10], values[11], values[12]]
  day2 = [values[13], values[14], values[15], values[16]]
  day3 = [values[17], values[18], values[19], values[20]]
  day4 = [values[21], values[22], values[23], values[24]]

  days = [day0, day1, day2, day3, day4]

  isCharging = values[25]


  # create an HTML string to be displayed by the widget
  htmlString = @getWifiStatus(connum) + "<span class='weather'>" + @getWeatherIcon(connum) + @colorizeTemp(temp) + "</span>" + @batteryStatus(battery, isCharging) + @timeAndDate(date, time);
  $(domEl).find('.compstatus').html(htmlString)

  # forecastString = "<table><tr><td>" + @getWeatherIcon(parseInt(days[0][2])) + "</td></tr></table>"

  forecastString = "<table>";

  for day in days
    forecastString = forecastString + "<tr>" + "<td class='white'>#{day[3]}</td>" + "<td>" + @getWeatherIcon(parseInt(day[2])) + "</td>" + "<td>" + @colorizeTemp(day[0]) + "</td>" + "<td>" + @colorizeTemp(day[1]) + "</td>" + "</tr>";

  forecastString = forecastString + "</table>";
  
  $(domEl).find('.weather_forecast').html(forecastString)

  # weather forecast script
  isForecastVisable = false
  
  $(".weather").on "click", ->
    console.log("button clicked!")
    if isForecastVisable == false
      $(".weather_forecast").css("opacity", "1");
      isForecastVisable = true;
    else
      $(".weather_forecast").css("opacity", "0");
      isForecastVisable = false;
