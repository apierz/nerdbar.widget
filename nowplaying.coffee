command: "sh ~/.kwm/scripts/mpd.sh"

refreshFrequency: '2s' # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="/nerdbar.widget/colors.css" />
    <div class='nowplaying'></div>
    <div class='torrentStatus'></div>
  """

style: """
  -webkit-font-smoothing: antialiased
  color: #66d9ef
  font: 12px Hack
  left: 8px
  bottom: 8px
  width:850px
  height: 16px
  .torrentStatus
    position: relative
    bottom: 15px
"""

update: (output, domEl) ->

   values = output.split('@');
   artist = values[0].replace /^\s+|\s+$/g, ""
   song = values[1].replace /^\s+|\s+$/g, ""
   elapsed = values[2]
   status = values[3].replace /^\s+|\s+$/g, ""
   torrentPercentage = values[4]
   torrentsPending = values[5]
   torrentsComplete = values[6].replace /^\s+|\s+$/g, ""
   trackCount = values[7].replace /^\s+|\s+$/g, ""


   if artist.length >= 12
     artist = artist.substring(0,11)
     artist = artist.replace /^\s+|\s+$/g, "" + "…"

   if song.length >= 17
     song = song.substring(0,16)
     song = song.replace /^\s+|\s+$/g, "" + "…"

   # Create mpdHtmlString
   mpdHtmlString = "<span class='icon switch'></span><span class='white'> (#{trackCount}) #{artist} - #{song}&nbsp&nbsp</span>"

   emptySpace = (55 - artist.length - song.length) / 2

   elapsedCounter = parseInt(elapsed * emptySpace / 100 )
   remainingCounter = emptySpace - elapsedCounter - 1



   mpdHtmlString += "<span class='blue'>";
   i = 0
   while i <= elapsedCounter
     i += 1;
     mpdHtmlString += " ●";

   mpdHtmlString += "</span>";
   mpdHtmlString += "<span class='white'>";

   i = 0
   while i <= remainingCounter
     i += 1;
     mpdHtmlString += " ●";


   mpdHtmlString += "</span>"

   if artist != ""
     mpdHtmlString += "<span class='sicon prev'>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>" + " "

     if status == "[playing]"
        mpdHtmlString += "<span class='sicon pause'></span>" + " "
     else
        mpdHtmlString += "<span class='sicon play'></span>" + " "

     mpdHtmlString += "<span class='sicon next'></span>"



   completedCounter = parseInt(26 * (torrentPercentage / 100 ))
   remainingTorCounter = 25 - completedCounter

   torrentString = "<span class='icon switch'>&nbsp</span><span class='white'>Torrent Status: </span><span class='blue'>";

   i = 0
   while i <= completedCounter
     i += 1;
     torrentString += " ●";

   torrentString += "</span>";
   torrentString += "<span class='white'>";

   i = 0
   while i <= remainingTorCounter
     i += 1;
     torrentString += " ●";

   torrentString += "&nbsp&nbsp(#{torrentsPending} / #{torrentsComplete}) </span>"


   $(domEl).find('.nowplaying').html(mpdHtmlString)
   $(domEl).find('.torrentStatus').html(torrentString)

   isNowPlayingVis = true

   $(".switch").on "click", ->
     console.log("switch clicked!")
     if isNowPlayingVis == false
       $(".nowplaying").css("opacity", "1");
       $(".nowplaying").css("z-index", "3");
       $(".torrentStatus").css("opacity", "0");
       $(".torrentStatus").css("z-index", "-1");
       isNowPlayingVis = true;
     else
       $(".nowplaying").css("opacity", "0");
       $(".nowplaying").css("z-index", "-1");
       $(".torrentStatus").css("opacity", "1");
       $(".torrentStatus").css("z-index", "2");
       isNowPlayingVis = false;


   $(".pause").on "click", => @run "/usr/local/bin/mpc pause";
   $(".play").on "click", => @run "/usr/local/bin/mpc play"
   $(".next").on "click", => @run "/usr/local/bin/mpc next";
   $(".prev").on "click", => @run "/usr/local/bin/mpc prev";

afterRender: (domEl) ->
   $(".torrentStatus").css("opacity", "0");
   $(".torrentStatus").css("z-index", "-1");

