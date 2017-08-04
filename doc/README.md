# go-gu docs

## Git toolng
So anyone can easily participate. 
MakeFile hooks into golang git code that does lots of things for you.

http://godoc.org/github.com/libgit2/git2go?importers

https://sourcegraph.com/github.com/fuchsia-mirror/jiri@master/-/blob/gitutil/git.go#L12:11
- Has best lib

## Core

Shiny is the core

dskinner versus ebiten
- ebiten uses a glcanvas at the java and objective c level for mobile and then glfw for desktop.
- dskinner is using Shiny. But how to sign his code because he is using gomobile build, rather than gomobile bind ?



## Build container
- codegen file layout container
- inputs:
	- signing
	- intents
	- etc

## Build
- some rebuilds the Build container so its indempotent and has concise API as it were.
- xlab has some nice command line packaging code to avoid having to jump into Android Studio and XCode.

## Layout / Reflow
The "core" of the GUI takes care of lay-outing and positioning.  
And, you can create your own little widgets easily, while the "core" takes care of that lay-outing and positioning.

shiny has the FLex package but its a bit limiting.
the new cssgrid is a much better approahc and i think can be done is golang pretty fast.

Needs concept of scrollable area and docks too. Even a basic TextBox needs scrolling.

https://gist.github.com/htrob/7eddea79a8dbe673e5b4d0bb048726b0
https://github.com/gen2brain/raylib-go/tree/master/raygui

## Widgets
These stand on their own.

Basic set of course.
Text Editor is the hard one as getting layout and scrolling working well is tough.


