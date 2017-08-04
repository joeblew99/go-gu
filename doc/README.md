# go-gu docs

## Git toolng
So anyone can easily participate. 
MakeFile hooks into golang git code that does lots of things for you.

http://godoc.org/github.com/libgit2/git2go?importers

https://sourcegraph.com/github.com/fuchsia-mirror/jiri@master/-/blob/gitutil/git.go#L12:11
- Has best lib


## Build container
- codegen file layout container. As the Key Native stuff is done, we can then code gen more.
- inputs:
	- signing
	- intents
	- etc
- asset bundling so that stuff on disk is embedded into the exe
	- you want a GUI component to declare if its bundled or not, so that you can work on both at the same time
	- https://github.com/gu-io/gu/tree/master/assets
		- try it.


## Build
- some rebuilds the Build container so its indempotent and has concise API as it were.
- xlab has some nice command line packaging code to avoid having to jump into Android Studio and XCode.
- bitrise has lots of tooling to get this easy.


## Layout / Reflow
The "core" takes care of that lay-outing and positioning.
The Widgets knwo nothing about layout.

CssGrid looks like the most promising. Not going to go into why but see the way templating works.
Shiny has the Flex package and its not enough...

https://github.com/dskinner/x
- Has a good approach for widgets living independent of the layout.

https://github.com/gomatcha/matcha/tree/master/layout
- Looks promising, but need to try

Scrolling
Needs concept of scrollable area and docks too. Even a basic TextBox needs scrolling.
This has the basics
https://github.com/hajimehoshi/ebiten/blob/master/examples/ui/main.go#L215



https://gist.github.com/htrob/7eddea79a8dbe673e5b4d0bb048726b0
https://github.com/gen2brain/raylib-go/tree/master/raygui

## Widgets

Material Design basic set is a good starting point.
https://github.com/material-components/material-components-web
- web ones but has a demo to get the point across

A Great Start is here:
https://github.com/dskinner/x/tree/master/glw/example/glwidget

Text Editor is the hard one as getting layout and scrolling working well is tough.

## Widget - TextBox
This is a core thng and take a bit of work to get right.
There are a few examples of people getting it working with Shiny but they need adaptation.
Most of the code is a mess.

## Text
Need Text to look good and have TTF fonts and all the normal Text things.
Ebiten UI works ok.

## 2D Drawings
Eventually you need to draw stuff :)

https://github.com/fogleman/gg
- Good image based way

https://github.com/llgcode/draw2d
- This is a good base for 2D aspects
- Has decent Text support.
Heavily used: https://godoc.org/github.com/llgcode/draw2d?importers
https://github.com/Drahoslav7/penego/blob/master/gui/draw.go
Great example of 2d Surface layout tooling.


