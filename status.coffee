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
  .wifi
    font: 14px FontAwesome
    top: 1px
    position: relative
    left: 10px
  .charging
    font: 12px FontAwesome
    position: relative
    top: 0px
    right: -11px
    z-index: 1
  """
timeAndDate: (date, time) ->
  # returns a formatted html string with the date and time
  return "<span class='white'><span class='icon'>&nbsp</span>#{date}&nbsp<span class='icon'></span>#{time}</span></span>";

batteryStatus: (battery, state) ->
  #returns a formatted html string current battery percentage, a representative icon and adds a lighting bolt if the
  # battery is plugged in and charging
  batnum = parseInt(battery)
  if state == 'AC' and batnum >= 90
    return "<span class='charging white sicon'></span><span class='green icon '></span><span class='white'>#{batnum}%</span>"
  else if state == 'AC' and batnum >= 50 and batnum < 90
    return "<span class='charging white icon'></span><span class='green icon'></span><span class='white'>#{batnum}%</span>"
  else if state == 'AC' and batnum < 50 and batnum >= 15
    return "<span class='charging white icon'></span><span class='yellow icon'></span><span class='white'>#{batnum}%</span>"
  else if state == 'AC' and batnum < 15
    return "<span class='charging white icon'></span><span class='red icon'></span><span class='white'>#{batnum}%</span>"
  else if batnum >= 90
    return "<span class='green icon'>&nbsp</span><span class='white'>#{batnum}%</span>"
  else if batnum >= 50 and batnum < 90
    return "<span class='green icon'>&nbsp</span><span class='white'>#{batnum}%</span>"
  else if batnum < 50 and batnum >= 15
    return "<span class='yellow icon'>&nbsp</span><span class='white'>#{batnum}%</span>"
  else if batnum < 15
    return "<span class='red icon'>&nbsp</span><span class='white'>#{batnum}%</span>"

getWifiStatus: (status, netName, netIP) ->
  if status == "Wi-Fi"
    return "<span class='wifi '>&nbsp&nbsp&nbsp</span><span class='white'>#{netName}&nbsp</span>"
  if status == 'USB 10/100/1000 LAN' or status == 'Apple USB Ethernet Adapter'
    return "<span class='wifi '>&nbsp&nbsp&nbsp</span><span class='white'>#{netIP}</span>"
  else
    return "<span class='grey wifi'>&nbsp&nbsp&nbsp</span><span class='white'>--&nbsp&nbsp&nbsp</span>"

update: (output, domEl) ->

  # split the output of the script
  values = output.split('@')

  time = values[0].replace /^\s+|\s+$/g, ""
  date = values[1]
  battery = values[2]
  isCharging = values[3]
  netStatus = values[4].replace /^\s+|\s+$/g, ""
  netName = values[5]
  netIP = values[6]

  # create an HTML string to be displayed by the widget
  htmlString = @getWifiStatus(netStatus, netName, netIP) +
               @batteryStatus(battery, isCharging) + "<span class='blue'>" + " ⎢" + "</span>" +
               @timeAndDate(date,time) + "<span class='blue' class=''> ⎢</span>"

  $(domEl).find('.compstatus').html(htmlString)
