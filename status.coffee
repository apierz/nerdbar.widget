command: "~/.kwm/scripts/compstatus"

refreshFrequency: 3000 # ms

render: (output) ->
  "<div class='compstatus'></div>"

style: """
  -webkit-font-smoothing: antialiased
  font: 12px Hack
  text-transform: lowercase
  right: 50px
  top: 5px
  color: #66d9ef
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
  .white
    color: #f8f8f2
  .green
    color: #a6e22e
  .greenbg
    background: #a6e22e
    color: #272822
  .yellow
    color: #e6db74
  .yellowbg
    background: #e6db74
    color: #272822
  .red
    color: #f92672
  .icon
    position: relative
    top: 1px
    font: 14px fontawesome
  .weather
    font: 13px WeatherIcons-Regular
  .blue
    color: #66d9ef
  .cyan
    color: #a1efe4
  .cyanbg
    background: #a1efe4
    color: #272822
  .grey
    color: #64645e
  .purple
    color: #fd5ff0
  .orange
    color: #fd971f
  .orangebg
    background: #fd971f
    color: #272822
  .forecast
    background: #272822
"""

timeAndDate: (date, time) ->
  # returns a formatted html string with the date and time
  return "<span class='white'><span class='icon'>&nbsp&nbsp&nbsp </span>#{date}</span>   <span class='icon'></span>#{time}</span>";

batteryStatus: (battery, state) ->
  #returns a formatted html string current battery percentage, a representative icon and adds a lighting bolt if the
  # battery is plugged in and charging
  batnum = parseInt(battery)
  console.log(state)
  if state == 'AC' and batnum >= 90
    return "<span class='charging'>  </span><span ><span class='icon'> </span>#{batnum}%</span>"
  else if state == 'AC' and batnum >= 50 and batnum < 90
    return "<span class='charging'>  </span><span class='green'><span class='icon'> </span>#{batnum}%</span>"
  else if state == 'AC' and batnum < 50 and batnum >= 15
    return "<span class='charging'>  </span><span class='yellow'><span class='icon'> </span>#{batnum}%</span>"
  else if state == 'AC' and batnum < 15
    return "<span class='charging'>  </span><span class='red'><span class='icon'> </span>#{batnum}%</span>"
  else if batnum >= 90
    return "<span class='green'><span class='icon'>  </span>#{batnum}%</span>"
  else if batnum >= 50 and batnum < 90
    return "<span class='green'><span class='icon'>  </span>#{batnum}%</span>"
  else if batnum < 50 and batnum >= 15
    return "<span class='yellow'><span class='icon'>  </span>#{batnum}%</span>"
  else if batnum < 15
    return "<span class='red'><span class='icon'>  </span>#{batnum}%</span>"

getWifiStatus: (status) ->
  console.log(status)
  if status == "Wi-Fi"
    return "<span class='wifi'>&nbsp&nbsp</span>";
  if status == 'USB 10/100/1000 LAN' or status == 'Apple USB Ethernet Adapter'
    return "<span class='wifi'>&nbsp&nbsp</span>";
  else
    return "<span class='grey wifi'>&nbsp&nbsp</span>";

getCPU: (cpu) ->
  cpuNum = parseFloat(cpu)
  # I have four cores, so I divide my CPU percentage by four to get the proper number
  cpuNum = cpuNum/4
  cpuNum = cpuNum.toFixed(1)
  return "<span class='greenbg icon'>&nbsp</span><span class='greenbg'>#{cpuNum}%&nbsp</span><span>&nbsp</span>"

getMem: (mem) ->
  memNum = parseFloat(mem)
  # correct for wierd reporting
  memNum = memNum * 5 / 8
  memNum = memNum.toFixed(1)
  return "<span class='yellowbg icon'>&nbsp</span><span class='yellowbg'>#{memNum}%&nbsp</span><span>&nbsp</span>"

convertBytes: (bytes) ->
  kb = bytes / 1024
  return @usageFormat(kb)

usageFormat: (kb) ->
  # if kb > 1024
    mb = kb / 1024
    "#{parseFloat(mb.toFixed(2))}MB"
  # else
    # "#{parseFloat(kb.toFixed(3))} KB/s"

getNetTraffic: (down, up) ->
  downString = @convertBytes(parseInt(down))
  upString = @convertBytes(parseInt(up))
  return "<span>&nbsp</span><span class='icon cyanbg'></span><span class='cyanbg'>#{downString}</span><span>&nbsp</span><span class='icon orangebg'></span><span class='orangebg'>#{upString}</span> "



update: (output, domEl) ->

  # split the output of the script
  values = output.split('@');
  
  time = values[0].replace /^\s+|\s+$/g, ""
  date = values[1];
  battery = values[2];
  isCharging = values[3]

  cpu = values[4]
  mem = values[5]

  down = values[6]
  up   = values[7]

  netStatus = values[8].replace /^\s+|\s+$/g, ""



  # create an HTML string to be displayed by the widget
  htmlString = @getWifiStatus(netStatus) + @batteryStatus(battery, isCharging) + "<span class='icon'>&nbsp</span>" + @getNetTraffic(down, up) + @getMem(mem) + @getCPU(cpu) + "<span class='icon'>&nbsp&nbsp</span>" + @timeAndDate(date, time) 
  $(domEl).find('.compstatus').html(htmlString)
  
