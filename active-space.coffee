command: "echo $(/usr/local/bin/kwmc query window focused name)"

refreshFrequency: 1000 # ms

render: (output) ->
  "#{output}"

style: """
  -webkit-font-smoothing: antialiased
  color: #f8f8f2
  font: 12px Hack
  height: 16px
  left: 10px
  overflow: hidden
  text-overflow: ellipsis
  top: 6px
  width: 500px
"""
