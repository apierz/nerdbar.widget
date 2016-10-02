# Bar

Personal [Übersicht](http://tracesof.net/uebersicht/) system information bar for use with [Kwm](https://github.com/koekeishiya/kwm) window manager and designed to look good with [Doom Theme](http://github.com/hlissner/emacs-doom-theme).

Originally created by [herrbischoff](https://github.com/herrbischoff).

Further modifications were made by [koekeishiya](https://github.com/koekeishiya), whose version can be found [here](https://github.com/koekeishiya/nerdbar.widget).

*Screen Shot:*
![img](https://github.com/apierz/nerdbar.widget/blob/master/screenshot.png?raw=true)


The original widget created by *herrbischoff* can be found [here](https://github.com/herrbischoff/nerdbar.widget).

You can find the necessary scripts in my [Dotfiles](http://github.com/apierz/dotfiles) directory in the kwm folder.

## Added Features:

* Battery indicator changes color (green -> yellow -> red) based on percentage left.
* when looking at a file in Emacs, the file name will be highlighted white, while the rest shows in Doom Blue color
* Now inclues a weather widget that tells you Temperature and Conditions for your location. Uses Yahoo weather API.
* Network connection indicator widget

## Installation

Make sure you have [Übersicht](http://tracesof.net/uebersicht/) installed.

Then clone this repository.

```bash
git clone https://github.com/apierz/nerdbar.widget $HOME/Library/Application\ Support/Übersicht/widgets/nerdbar.widget
```

I use [Hack](http://sourcefoundry.org/hack/) for the main text, [FontAwesome](http://fontawesome.io) for the icons and [All-the-icons](https://github.com/domtronn/all-the-icons.el) for the weather icons.
