command: "sh ~/.kwm/scripts/mpd.sh"

refreshFrequency: 3000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="/nerdbar.widget/colors.css" />
    <div class='nowplaying'></div>
  """

style: """
  -webkit-font-smoothing: antialiased
  color: #66d9ef
  font: 12px Hack
  left: 8px
  bottom: 7px
  width:850px
  height: 16px
"""

update: (output, domEl) ->

   values = output.split('@');
   artist = values[0].replace /^\s+|\s+$/g, ""
   song = values[1].replace /^\s+|\s+$/g, ""
   elapsed = values[2]
   length = values[3]

   times  = elapsed.split(':');
   elapsedMinutes = parseInt(times[0])
   elapsedSeconds = parseInt(times[1])
   elapsedTotal = 60 * elapsedMinutes + elapsedSeconds

   console.log(elapsedTotal)

   times  = length.split(':');
   lengthMinutes = parseInt(times[0])
   lengthSeconds = parseInt(times[1])
   lengthTotal = 60 * lengthMinutes + lengthSeconds

   console.log(lengthTotal)

   htmlString = "<span class='icon'></span><span class='white'> #{artist} - #{song}&nbsp&nbsp</span>"

   emptySpace = (60 - artist.length - song.length) / 2

   console.log(emptySpace)

   elapsedCounter = parseInt(elapsedTotal / lengthTotal * emptySpace )
   remainingCounter = emptySpace - elapsedCounter

   console.log(elapsedCounter)
   

   htmlString += "<span class='blue'>";
   i = 0
   while i <= elapsedCounter 
     i += 1;
     htmlString += " ●";

   htmlString += "</span>";
   htmlString += "<span class='white'>";

   i = 0
   while i <= remainingCounter
     i += 1;
     htmlString += " ●";


   htmlString += "</span>"

   if artist != "" 
     htmlString += "<span class='sicon prev'>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>" + " "
     htmlString += "<span class='sicon pause'></span>" + " "
     htmlString += "<span class='sicon play'></span>" + " "
     htmlString += "<span class='sicon next'></span>"

     

   $(domEl).find('.nowplaying').html(htmlString)

   $(".pause").on "click", => @run "/usr/local/bin/mpc pause" 
   $(".play").on "click", => @run "/usr/local/bin/mpc play" 
   $(".next").on "click", => @run "/usr/local/bin/mpc next" 
   $(".prev").on "click", => @run "/usr/local/bin/mpc prev" 
