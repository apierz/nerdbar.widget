command: "~/.kwm/scripts/compstatus"

refreshFrequency: 1000 # ms

render: (output) ->
  "<div class='compstatus'></div>"

style: """
  -webkit-font-smoothing: antialiased
  font: 12px Hack
  text-transform: lowercase
  right: 10px
  top: 6px
  color: #00b3ef
  .white
    color: #eeeeee
  .green
    color: #7bc275
  .yellow
    color: #ecbe7b
  .red
    color: #ff665c
  .icon
    font: 12px fontawesome
"""

update: (output, domEl) ->

  values = output.split('@', 4);
  time = values[0];
  date = values[1];
  battery = values[2];
  batnum = parseInt(battery);

  if batnum >= 90
    $(domEl).find('.compstatus').html("<span class='green'><span class='icon'> </span>#{battery}</span>  <span class='white'>  <span class='icon'></span> #{date} </span> <span class='icon'></span> #{time} </span>" )

  if batnum >= 50 and batnum < 90
    $(domEl).find('.compstatus').html("<span class='green'><span class='icon'> </span>#{battery}</span>  <span class='white'> <span class='icon'></span> #{date} </span> <span class='icon'></span> #{time} </span>" )

  if batnum < 50 and batnum >= 15
    $(domEl).find('.compstatus').html("<span class='yellow'><span class='icon'> </span>#{battery}</span>  <span class='white'> <span class='icon'></span> #{date} </span> <span class='icon'></span> #{time} </span>" )

  if batnum < 15
    $(domEl).find('.compstatus').html("<span class='red'><span class='icon'> </span>#{battery}</span>  <span class='white'> <span class='icon'></span> #{date} </span> <span class='icon'></span> #{time} </span>" )
