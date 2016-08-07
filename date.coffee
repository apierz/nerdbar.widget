command: "date +\"%d%b%y\""

refreshFrequency: 10000

render: (output) ->
  "#{output}"

style: """
  -webkit-font-smoothing: antialiased
  text-transform: lowercase
  color: #ff79c6
  font: 12px Hack
  right: 60px
  top: 6px
"""
