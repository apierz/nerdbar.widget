command: "~/.kwm/scripts/screens"

refreshFrequency: 1000 # ms

render: (output) ->
  " <div class='kwmmode'></div>"


style: """
  -webkit-font-smoothing: antialiased
  color: #00b3ef
  background: #262c34
  font: 12px Hack
  left: 10px
  top: 6px
  width: 900px
  span2
    color: #eeeeee
  .icon
    font 12px fontawesome
"""

update: (output, domEl) ->

  values = output.split('@', 4);

  file = "";
  mode = values[0];
  screens = values[1];
  wins = values[2];
  win = "";
  i = 0;

  winseg = wins.split('/');
  
  for seg in winseg
    i += 1;
    if i == winseg.length
      file += seg;
      break;
      
    win += seg;
    win += '/';
      

  $(domEl).find('.kwmmode').html("<span><span class='icon'> </span>#{mode} <span class='icon'> </span> #{screens} <span class='icon'> </span> #{win}</span><span2>#{file}</span2>")

