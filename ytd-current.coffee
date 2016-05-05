command: "echo $(/usr/local/bin/ytc current)"

refreshFrequency: 1000 # ms

render: (output) ->
  """
  <link rel="stylesheet" href="./assets/font-awesome/css/font-awesome.min.css" />
  <div class="np"
    <span></span>
    <span class="icon"></span>
  </div>
  """

update: (output, el) ->
    $(".np span:first-child", el).text("  #{output}")
    $icon = $(".np span.icon", el)
    $icon.removeClass().addClass("icon")
    $icon.addClass("fa #{@icon(output)}")

icon: (status) =>
    return if status.substring(0, 9) == "[stopped]"
        "fa-stop-circle-o"
    else if status.substring(0, 8) == "[paused]"
        "fa-pause-circle-o"
    else if status.substring(0, 17) == "Connection failed"
        "fa-times-circle-o"
    else
        "fa-play-circle-o"

style: """
  -webkit-font-smoothing: antialiased
  text-align: center
  color: #d5c4a1
  font: 10px Input
  height: 16px
  left: 25%
  overflow: hidden
  text-overflow: ellipsis
  top: 6px
  width: 50%
"""
