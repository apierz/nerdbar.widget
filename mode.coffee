command: "~/.kwm/scripts/screens"

refreshFrequency: 1000 # ms

render: (output) ->
  " <div class='kwmmode'></div>"


style: """
  -webkit-font-smoothing: subpixel-antialiased
  color: #b6e63e
  font: 12px Hack
  left: 10px
  top: 7px
  width: 880px
  height: 14px
  white-space: nowrap
  text-overflow: ellipsis
  overflow: ellipsis
  span2
    color: #d6d6d4
  .icon
    font 12px fontawesome
  .green
    color: #b6e63e
  .yellow
    color: #e2c770
  .cyan
    color: #66d9ef
  .white
    color: #d6d6d4
  .active
    color: #1d1f20
    background: #b6e63e
  .inactive
    color: #1d1f20
    background: #c0c5cf
"""

update: (output, domEl) ->

  values = output.split('@', 4);

  file = "";
  screenhtml = "";
  mode = values[0];
  screens = values[1];
  wins = values[2];
  win = "";
  i = 0;

  screensegs = screens.split('(');
  console.log(screens)

  for sseg in screensegs
    screensegs[i] = sseg.replace /^\s+|\s+$/g, ""
    i+=1;

  screensegs = (x for x in screensegs  when x != '')

  i = 0;

  for sseg in screensegs
    console.log(sseg)
    i+= 1;
    if sseg.slice(-1) == ")"
      screenhtml += "<span class='active'>&nbsp;" + i.toString() + ':' + sseg.slice(0, -1) + "&nbsp;</span><span>&nbsp;</span>" ;
    else
      screenhtml += "<span class='inactive'>&nbsp;" + i.toString() + ':' + sseg + "&nbsp;</span><span>&nbsp;</span>";

  i = 0;

  winseg = wins.split('/');
  
  for seg in winseg
    i += 1;
    if i == winseg.length
      file += seg;
      break;
      
    win += seg;
    win += '/';
      

  $(domEl).find('.kwmmode').html("<span>#{mode}  " + screenhtml + "</span>  #{win}</span><span2>#{file}</span2>")
    
  

