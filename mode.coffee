command: "~/.kwm/scripts/screens"

refreshFrequency: 100 # ms

render: (output) ->
  " <div class='kwmmode'></div>"


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
  span2
    color: #f8f8f2
  .icon
    font: 14px fontawesome
    top: 1px
    position relative
  .green
    color: #a6e22e
  .yellow
    color: #e6db74
  .cyan
    color: #a1efe4
  .white
    color: #f8f8f2
  .active
    color: #272822
    background: #66d9ef
  .inactive
    color: #272822
    background: lightgrey
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

  for sseg in screensegs
    screensegs[i] = sseg.replace /^\s+|\s+$/g, ""
    i+=1;

  screensegs = (x for x in screensegs  when x != '')

  i = 0;

  for sseg in screensegs
    i+= 1;
    if sseg.slice(-1) == ")"
      screenhtml += "<span class='active'>&nbsp;" + i.toString() + ':' + sseg.slice(0, -1) + "&nbsp;</span><span>&nbsp;</span>" ;
    else
      screenhtml += "<span class='inactive'>&nbsp;" + i.toString() + ':' + sseg + "&nbsp;</span><span>&nbsp;</span>";

  winseg = wins.split('/');
  file = winseg[winseg.length - 1]
  j = winseg.length - 1
  flag = 0
  
  if j > 1
    while j >= 1
      j -= 1;
      if (win + file).length >= 48
        win = '…/' + win
        break;
      else
        win = winseg[j] + '/' + win;

   while file.length >= 48
    file = file.slice(0, -1)
    flag = 1

   if flag >= 1
     file = file + '…';


  $(domEl).find('.kwmmode').html("<span>#{mode}</span><span class='icon'> </span> " + screenhtml + "<span class='icon'> </span> <span>#{win}</span><span2>#{file}</span2>")
    
  

