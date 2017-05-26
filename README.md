# Bars

Personal [Übersicht](http://tracesof.net/uebersicht/) system information bars for use with [Kwm](https://github.com/koekeishiya/kwm) window manager and designed with colors from the [Nord](https://github.com/arcticicestudio/nord) theme.

*Screen Shots:*
![img](https://github.com/apierz/nerdbar.widget/blob/master/screens/screenshotone.png?raw=true)
![img](https://github.com/apierz/nerdbar.widget/blob/master/screens/screenshottwo.ong.png?raw=true)


The original widget created by *herrbischoff* can be found [here](https://github.com/herrbischoff/nerdbar.widget).

Further modifications were made by [koekeishiya](https://github.com/koekeishiya), whose version can be found [here](https://github.com/koekeishiya/nerdbar.widget).


# How it works:

## Ubersicht

[Übersicht](http://tracesof.net/uebersicht/) creates a webview and places it on your desktop, just above the wallpaper but behind everyting else. Ubersicht widgets are written as .coffee files which let you format elements with html, style them with css and manipulate data with javascript and coffeescript. For dynamic widgets, Ubersicht let's you run terminal commands and insert the output into html, so just about any language can be used to write scripts for widgets. My scripts use bash, python and AppleScript.

You can find the necessary scripts in scripts directory.

### Backgrounds
These are as simple as Ubersicht widgets get, they make black bars at the top, bottom left and bottom right of the screen that the other widgets sit on top of.


### mode.coffee
![img](https://github.com/apierz/nerdbar.widget/blob/master/screens/screenshotthree.png?raw=true)

This widget is designed to work with KWM. It shows the current KWM mode (bsp, float, monocle) and the number of desktops and the current one. If enabled in the Ubersicht preferences menu, holding the interaction key and clicking on the mode will cycle through the KWM modes and clicking on desktop icons will change the current desktop to the one clicked on. This works best if your interaction shortcut is ctrl.

### currentWindow.coffee
![img](https://github.com/apierz/nerdbar.widget/blob/master/screens/screenshotfour.png?raw=true)

This widget shows the currently selected window. If working on a file, it can highlight the name of the file being worked on.

### status.coffee
![img](https://github.com/apierz/nerdbar.widget/blob/master/screens/screenshot5.png?raw=true)

* This widget shows the current time and date.
* The battery widget changes color from green to yellow to red as battery percentage changes. Now has a little lightning bolt that will appear when the computer is plugged in (taken from [Mizzazz](https://github.com/Mizzazz/Betterbar)).
* Network connection indicator widget. Shows grey if no connection detected and blue if there's an active connection on Wi-Fi or Ethernet. Shows different icons for Wi-Fi and Ethernet and will show your IP or current wifi network name.
* Mail indicator shows number of new messages in your inbox. Works with Maildir
  style email storage.
* Reminders indicator shows number of uncompleted reminders in Apple's reminders app.

### weather.coffee
![img](https://github.com/apierz/nerdbar.widget/blob/master/screens/screenshot6.png?raw=true)

This used to be a part of status.coffee but since it uses an API call it was very inefficent to have it update every few seconds. It is now its own widget that updates every 10 minutes signifigantly reducing the resources used.

* The weather widget tells the current temperature ( color is blue, yellow or red depending on temperature) and an icon showing the current weather status. Uses the Yahoo Weather API for forecast data and [ip-api](http://ip.api.com) to determine current location.
* Clicking on the temperature loads a five day forecast panel with location, current condition, date, condition, and low and high temperatures for the week. To use, enable an interaction shortcut in the Übersicht preference menu and hold down that key while clicking on the temperature.

### stats.coffee
![img](https://github.com/apierz/nerdbar.widget/blob/master/screens/screenshot7.png?raw=true)

This widget shows a number of current system indicators.

* Network upload and download traffic, adapted from [dionmonk's](https://github.com/dionmunk) [ubersicht-network-throughput](https://github.com/dionmunk/ubersicht-network-throughput) widget.
* Current memory and CPU percentage
* Current free HD space in gb

### nowplaying.coffee
![img](https://github.com/apierz/nerdbar.widget/blob/master/screens/screenshot9.png?raw=true)
![img](https://github.com/apierz/nerdbar.widget/blob/master/screens/screenshot8.png?raw=true)

This widget works with MPD and NCMPCPP and the Transmission cli torrent client. It shows the current track and artist, the position in current track and has some simple play controls.

Clicking on the icon while holding the interaction key will toggle the widget between current MPD status and the current download progress of active torrents and the number of downloading / total.

There is also a Spotify widget included but you must
`brew install shpotify`
a command line spotify utility by [hnarayanan](https://github.com/hnarayanan) first

### volume.coffee
![img](https://github.com/apierz/nerdbar.widget/blob/master/screens/screenshot10.png?raw=true)

You can slide the range control to adjust volume. Icon changes with volume level.

## Installation

Make sure you have [Übersicht](http://tracesof.net/uebersicht/) installed.

Then clone this repository.

```bash
git clone https://github.com/apierz/nerdbar.widget $HOME/Library/Application\ Support/Übersicht/widgets/nerdbar.widget
```

or to your current widget directory if you have changed it.
The scripts may require installing some additional packages, such as Python, but all are available via homebrew.


The icons require the use of extra fonts:

* [FontAwesome](http://fontawesome.io) for the icons
* [All-the-icons](https://github.com/domtronn/all-the-icons.el) for the weather icons.

That have to be installed system wide. You can drag the files into FontBook.app to do this.
