command: "~/.kwm/scripts/screens"

refreshFrequency: 3000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="/nerdbar.widget/colors.css" />
    <div class='kwmmode'></div>
  """

style: """
  -webkit-font-smoothing: antialiased
  color: #66d9ef
  font: 12px Hack
  left: 10px
  top: 7px
  width:850px
  height: 16px
  white-space: nowrap
  text-overflow: ellipsis
  overflow: ellipsis
"""

update: (output, domEl) ->

  values = output.split('@');

  file = "";
  screenhtml = "";
  mode = values[0];
  screens = values[1];
  wins = values[2];
  win = "";
  i = 0;

  screensegs = screens.split('(');

  for sseg in screensegs
    screensegs[i] = sseg.replace /^\s+|\s+$/g, ""
    i+=1;

  screensegs = (x for x in screensegs  when x != '')

  i = 0;

  #apply a proper number tag so that space change controls can be added
  for sseg in screensegs
    i+= 1;
    if sseg.slice(-1) == ")"
      screenhtml += "<span class='icon screen#{String(i)}'>&nbsp;&nbsp;&nbsp;</span>" ;
    else
      screenhtml += "<span class='icon white screen#{String(i)}'>&nbsp;&nbsp;&nbsp;</span>" ;

  #display the html string
  $(domEl).find('.kwmmode').html("<span class='tilingMode icon'></span><span class='tilingMode white'>#{mode} <span class='blue'> ⎢ </span></span>" + screenhtml)

  
  #add screen controls to screen icons
  i = 0
  for sseg in screensegs
    i+=1;
    $(".screen#{String(i)}").on 'click', => @run "/usr/local/bin/kwmc space -fExperimental #{String(i)}"

  
  # cycle through KWM space modes by clicking on the mode icon or mode name
  if mode == "[bsp] "
    $(".tilingMode").on 'click', => @run "osascript -e 'tell application \"System Events\" to key code 1 using {control down, command down}'"
  if mode == "[float] "
    $(".tilingMode").on 'click', => @run "osascript -e 'tell application \"System Events\" to key code 0 using {control down, command down}'"
  else
    $(".tilingMode").on 'click', => @run "/usr/local/bin/kwmc space -t float"
