command: "sh ./scripts/mpd.sh && sh ./scripts/torrent_script"

refreshFrequency: '2s' # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./colors.css" />
    <div class='nowplaying'></div>
    <div class='torrentStatus'></div>
  """

style: """
  color: #66d9ef
  font: 12px Hack
  left: 8px
  bottom: 12px
  width:850px
  height: 16px
  cursor: pointer;
  .torrentStatus
    position: relative
    bottom: 15px
"""

cutWhiteSpace: (text) ->
  text.replace /^\s+|\s+$/g, ""

update: (output, domEl) ->

   values = output.split('@')
   artist = @cutWhiteSpace(values[0])
   song = @cutWhiteSpace(values[1])
   elapsed = values[2]
   status = @cutWhiteSpace(values[3])
   trackCount = @cutWhiteSpace(values[4])
   if torrentsPending != ""
     torrentPercentage = values[5]
     torrentsPending = values[6]
     torrentsComplete = @cutWhiteSpace(values[7])

   if artist.length >= 25
     artist = artist.substring(0,24)
     artist = @cutWhiteSpace(artist)

   if song.length >= 25
     song = song.substring(0,24)
     song = @cutWhiteSpace(song)
     song = song + "…"

   # Create mpdHtmlString
   mpdHtmlString = "<span class='icon switch'></span><span class='white'> (#{trackCount}) #{artist} - #{song}&nbsp</span>"

   emptySpace = (80 - artist.length - song.length - 3)

   elapsedCounter = parseInt(elapsed * emptySpace / 100 )
   remainingCounter = emptySpace - elapsedCounter - 1



   mpdHtmlString += "<span>"
   i = 0
   while i <= elapsedCounter
     i += 1
     mpdHtmlString += "●"

   mpdHtmlString += "</span>"
   mpdHtmlString += "<span class='white'>"

   i = 0
   while i <= remainingCounter
     i += 1
     mpdHtmlString += "◦"

   mpdHtmlString += "</span>"

   if artist != ""
     mpdHtmlString += "<span class='sicon prev'>&nbsp&nbsp</span>" + " "

     if status == "[playing]"
        mpdHtmlString += "<span class='sicon pause'></span>" + " "
     else
        mpdHtmlString += "<span class='sicon play'></span>" + " "

     mpdHtmlString += "<span class='sicon next'></span>"



   completedCounter = parseInt(70 * (torrentPercentage / 100 ))
   remainingTorCounter = 69 - completedCounter

   torrentString = "<span class='icon switch'> </span><span class='white'>Torrent Status: </span><span>"

   i = 0
   while i <= completedCounter
     i += 1
     torrentString += "●"

   torrentString += "</span>"
   torrentString += "<span class='white'>"

   i = 0
   while i <= remainingTorCounter
     i += 1
     torrentString += "◦"

   torrentString += "</span><span class='white'>&nbsp&nbsp(#{torrentsPending} / #{torrentsComplete}) </span>"

   $(domEl).find('.nowplaying').html(mpdHtmlString)
   $(domEl).find('.torrentStatus').html(torrentString)

   isNowPlayingVis = true

   $(".switch").on "click", ->
     if isNowPlayingVis == false
       $(".nowplaying").css("opacity", "1")
       $(".nowplaying").css("z-index", "3")
       $(".torrentStatus").css("opacity", "0")
       $(".torrentStatus").css("z-index", "-1")
       isNowPlayingVis = true
     else
       $(".nowplaying").css("opacity", "0")
       $(".nowplaying").css("z-index", "-1")
       $(".torrentStatus").css("opacity", "1")
       $(".torrentStatus").css("z-index", "2")
       isNowPlayingVis = false

   $(".pause").on "click", => @run "/usr/local/bin/mpc pause"
   $(".play").on "click",  => @run "/usr/local/bin/mpc play"
   $(".next").on "click",  => @run "/usr/local/bin/mpc next"
   $(".prev").on "click",  => @run "/usr/local/bin/mpc prev"

afterRender: (domEl) ->
   $(".torrentStatus").css("opacity", "0")
   $(".torrentStatus").css("z-index", "-1")

