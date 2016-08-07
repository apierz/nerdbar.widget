command: "date +\"%H:%M\""

refreshFrequency: 10000 # ms

render: (output) ->
  "#{output}"

style: """
  -webkit-font-smoothing: antialiased
  color: #bd93f9
  font: 12px Hack
  right: 10px
  top: 6px
"""
