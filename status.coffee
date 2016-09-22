command: "~/.kwm/scripts/compstatus"

refreshFrequency: 1000 # ms

render: (output) ->
  "<div class='compstatus'></div>"

style: """
  -webkit-font-smoothing: antialiased
  font: 12px Hack
  right: 10px
  top: 6px
  color: #00b3ef
  .white
    color: #b5babf
    text-transform: lowercase
  .green
    color: #7bc275
  .yellow
    color: #ecbe7b
  .red
    color: #ff665c
  .bolt
    font: 12px fontawesome
"""

update: (output, domEl) ->

  values = output.split('@', 4);
  time = values[0];
  date = values[1];
  battery = values[2];
  batnum = parseInt(battery);

  if batnum >= 50
    $(domEl).find('.compstatus').html("<span class='green'><span class='bolt'></span>#{battery}</span>  <span class='white'> #{date} </span> #{time} </span>" )

  if batnum < 50 and batnum >= 15
    $(domEl).find('.compstatus').html("<span class='yellow'><span class='bolt'></span>#{battery}</span>  <span class='white'> #{date} </span> #{time} </span>" )

  if batnum < 15
    $(domEl).find('.compstatus').html("<span class='red'><span class='bolt'></span>#{battery}</span>  <span class='white'> #{date} </span> #{time} </span>" )
