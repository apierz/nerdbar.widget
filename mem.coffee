command: "ESC=`printf \"\e\"`; ps -A -o %mem | awk '{s+=$1} END {print \"\" s}'"

refreshFrequency: 30000 # ms

render: (output) ->
  "mem <span>#{output}</span>"

style: """
  -webkit-font-smoothing: antialiased
  color: #D5C4A1
  font: 12px Hack
  right: 185px
  top: 6px
  color: #f8f8f2
  span
    color: #ffb86c
"""
