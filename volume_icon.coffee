command: "sh ./scripts/getvolume.sh"

refreshFrequency: 5000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./colors.css" />
    <div class='volumeicon'></div>
  """

style: 
  """
  bottom: 10px
  left 773px
  """

update: (output, domEl) ->
  values = output.split('@')
  volume = parseInt(values[2])
  muted = values[3].replace /^\s+|\s+$/g, ""

  htmlstring = "<span class='vol_icon'>"

  if muted == "true"
    htmlstring += ""
  if muted == "false"
    if volume < 25
        htmlstring += ""
    if volume >= 25 and volume <= 75 
        htmlstring += ""
    if volume > 75
        htmlstring += ""
  htmlstring += "</span>"
  $(domEl).find(".volumeicon").html(htmlstring)


