# Bar

Personal [Übersicht](http://tracesof.net/uebersicht/) system information bar for use with [Kwm](https://github.com/koekeishiya/kwm) window manager and designed with colors from the classic Monokai theme.

Originally created by [herrbischoff](https://github.com/herrbischoff).

Further modifications were made by [koekeishiya](https://github.com/koekeishiya), whose version can be found [here](https://github.com/koekeishiya/nerdbar.widget).

*Screen Shot:*
![img](https://github.com/apierz/nerdbar.widget/blob/master/screenshot1.png?raw=true)


The original widget created by *herrbischoff* can be found [here](https://github.com/herrbischoff/nerdbar.widget).


# How it works:

## Ubersicht

[Übersicht](http://tracesof.net/uebersicht/) creates a webview and places it on your desktop, just above the wallpaper but behind everyting else. Ubersicht widgets are written as .coffee files which let you format elements with html, style them with css and manipulate data with javascript and coffeescript. For dynamic widgets, Ubersicht let's you run terminal commands and insert the output into html, so just about any language can be used to write scripts for widgets.

You can find the necessary scripts in my [Dotfiles](http://github.com/apierz/dotfiles) directory in the [kwm](http://github.com/apierz/dotfiles/tree/master/kwm) folder.

I find having a bunch of seperate widgets hard to align and keep consistent so I jam everything into a few widgets. They each run a script that outputs a bunch of data seperated by @s which I can then split and manipulate in the .coffee files.

### background.coffee
This is as simple as Ubersicht widgets get, it just makes a black bar at the top of the screen that the other widgets sit on top of.

### mode.coffee
![img](https://github.com/apierz/nerdbar.widget/blob/master/screenshot2.png?raw=true)

This widget is design to work with KWM. It shows the current KWM mode (bsp, float, monocle), the number of desktops and the current one, and the current selected window.

### status.coffee
![img](https://github.com/apierz/nerdbar.widget/blob/master/screenshot3.png?raw=true)

* This widget shows the current time and date.
* Recently added back indicators for memory and cpu %.
* Network upload and download traffic, adapted from [dionmonk's](https://github.com/dionmunk) [ubersicht-network-throughput](https://github.com/dionmunk/ubersicht-network-throughput) widget.
* The battery widget changes color from green to yellow to red as battery percentage changes. Now has a little lightning bolt will appear when the computer is plugged in (taken from [Mizzazz](https://github.com/Mizzazz/Betterbar)).
* Network connection indicator widget. Shows grey if no connection detected and blue if there's an active connection on Wi-Fi or LAN.

## weather.coffee
![img](https://github.com/apierz/nerdbar.widget/blob/master/screenshot4.png?raw=true)

This used to be a part of status.coffee but since it uses an API call it was very inefficent to have it update every few seconds. It is now its own widget that updates every 10 minutes signifigantly reducing the resources used.

* The weather widget tells the current temperature ( color is blue, yellow or red depending on temperature) and an icon showing the current weather status. Uses the Yahoo Weather API for forecast data and [ip-api](http://ip.api.com) to determine current location.
* Clicking on the temperature loads a five day forecast panel with date, condition, and low and high temperatures for the day. To use, enable an interaction shortcut in the Übersicht preference menu and hold down that key while clicking on the temperature.

## Installation

Make sure you have [Übersicht](http://tracesof.net/uebersicht/) installed.

Then clone this repository.

```bash
git clone https://github.com/apierz/nerdbar.widget $HOME/Library/Application\ Support/Übersicht/widgets/nerdbar.widget
```

I use [Hack](http://sourcefoundry.org/hack/) for the main text, [FontAwesome](http://fontawesome.io) for the icons and [All-the-icons](https://github.com/domtronn/all-the-icons.el) for the weather icons.
