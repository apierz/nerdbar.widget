command: "echo $(sh ~/.kwm/scripts/time_script)@$(sh ~/.kwm/scripts/date_script)@$(sh ~/.kwm/scripts/battery_percentage_script)%@$(sh ~/.kwm/scripts/battery_charging_script)@$(sh ~/.kwm/scripts/wifi_status_script)"

refreshFrequency: 3000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="/nerdbar.widget/colors.css" />
    <div class="compstatus"></div>
  """
  
style: """
  right: 55px
  top: 5px
  height: 13
  .weather_forecast
    width: 8em
    background: #272822
    top: 16px
    right: 100px
    opacity: 0
  .wifi
    font: 16px fontawesome
    top: 1px
    position: relative
  .charging
    font: 13px fontawesome
    color: #f8f8f2
    position: relative
    top: 1px
    right: -16px
    z-index: 1
  """

timeAndDate: (date, time) ->
  # returns a formatted html string with the date and time
  return "<span class='white'><span class='icon'>&nbsp&nbsp&nbsp</span>#{date}&nbsp<span class='icon'></span>#{time}</span></span>";

batteryStatus: (battery, state) ->
  #returns a formatted html string current battery percentage, a representative icon and adds a lighting bolt if the
  # battery is plugged in and charging
  batnum = parseInt(battery)
  if state == 'AC' and batnum >= 90
    return "<span class='charging'>  </span><span class='icon blue'> </span><span class='white'>#{batnum}%</span>"
  else if state == 'AC' and batnum >= 50 and batnum < 90
    return "<span class='charging'>  </span><span class='green icon'> </span><span class='white'>#{batnum}%</span>"
  else if state == 'AC' and batnum < 50 and batnum >= 15
    return "<span class='charging'>  </span><span class='yellow icon'> </span><span class='white'>#{batnum}%</span>"
  else if state == 'AC' and batnum < 15
    return "<span class='charging'>  </span><span class='red icon'> </span><span class='white'>#{batnum}%</span>"
  else if batnum >= 90
    return "<span class='green icon'>  </span><span class='white'>#{batnum}%</span>"
  else if batnum >= 50 and batnum < 90
    return "<span class='green icon'>  </span><span class='white'>#{batnum}%</span>"
  else if batnum < 50 and batnum >= 15
    return "<span class='yellow icon'>  </span><span class='white'>#{batnum}%</span>"
  else if batnum < 15
    return "<span class='red icon'>  </span><span class='white'>#{batnum}%</span>"

getWifiStatus: (status) ->
  if status == "Wi-Fi"
    return "<span class='wifi blue'>&nbsp</span>";
  if status == 'USB 10/100/1000 LAN' or status == 'Apple USB Ethernet Adapter'
    return "<span class='wifi blue'></span>";
  else
    return "<span class='grey wifi'>&nbsp</span>";

update: (output, domEl) ->

  # split the output of the script
  values = output.split('@');
  
  time = values[0].replace /^\s+|\s+$/g, ""
  date = values[1];
  battery = values[2];
  isCharging = values[3]
  netStatus = values[4].replace /^\s+|\s+$/g, ""

  # create an HTML string to be displayed by the widget
  htmlString = @getWifiStatus(netStatus) + 
               @batteryStatus(battery, isCharging) + "<span class='blue'>" + " ⎢" + "</span>" +
               @timeAndDate(date,time) + "<span class='blue'> ⎢</span>"

  $(domEl).find('.compstatus').html(htmlString)
   
