command: "sh ./scripts/getvolume.sh"

refreshFrequency: 2000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./colors.css" />
    <input class="greenbg"  id="volume" type="range" min="0" max="100" step="5" color="green"/>
  """

style: """
  -webkit-font-smoothing: antialiased
  left: 790px
  bottom: 13px
  width: 850px
  input[type=range]
    -webkit-appearance: none
  input[type=range]::-webkit-slider-thumb
    -webkit-appearance: none
  input[type=range]:focus
    outline: none
  input[type=range]::-webkit-slider-thumb
    -webkit-appearance: none;
    top: 10px
    height: 16px;
    width: 16px;
    border-radius: 8px;
    background: #e1e2e7;
    cursor: pointer;
    margin-top: -4.5px;
  input[type=range]::-webkit-slider-runnable-track
    width: 100%;
    height: 6px;
    cursor: pointer;
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
