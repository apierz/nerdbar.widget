command: "sh ./scripts/getvolume.sh"

refreshFrequency: 2000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./colors.css" />
    <input class="cyanbg"  id="volume" type="range" min="0" max="100" step="5" color="green"/>
  """

style: """
  -webkit-font-smoothing: antialiased
  left: 770px
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
    background: #ffffff;
    cursor: pointer;
    margin-top: -4.5px;
  input[type=range]::-webkit-slider-runnable-track
    width: 100%;
    height: 6px;
    cursor: pointer;
    box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
"""

update: (output, domEl) ->
  values = output.split('@')
  oldvol = parseInt(values[0])
  newvol = parseInt(values[1])
  muted = values[2].replace /^\s+|\s+$/g, ""


  if oldvol != newvol
    $("#volume").val(values[1])

  else
    slidvol = $("#volume").val()
    @run "osascript -e 'set volume output volume #{slidvol}'"
