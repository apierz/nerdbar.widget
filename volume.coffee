command: "sh ./scripts/getvolume.sh"

refreshFrequency: 2000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./colors.css" />
    <input id="volume" type="range" min="0" max="100" step="5" />
  """

style: """
  -webkit-font-smoothing: antialiased
  left: 790px
  bottom: 11px
  width: 850px
"""

update: (output, domEl) ->
  values = output.split('@')
  oldvol = parseInt(values[0])
  oldmute = values[1]
  newvol = parseInt(values[2])
  muted = values[3].replace /^\s+|\s+$/g, ""


  if oldvol != newvol or oldmute != muted
    $("#volume").val(values[2])

  if oldvol == newvol
    slidvol = $("#volume").val()
    @run "osascript -e 'set volume output volume #{slidvol}'"
