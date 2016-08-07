command: "pmset -g batt | egrep '([0-9]+\%).*' -o --colour=auto | cut -f1 -d'%'"

refreshFrequency: 150000 # ms

render: (output) ->
  "bat <span>#{output}<\span>"

style: """
  -webkit-font-smoothing: antialiased
  font: 12px Hack
  top: 6px
  right: 125px
  color: #f8f8f2
  span
    color: #f1fa8c
"""
