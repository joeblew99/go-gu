# go-gu docs

## Build container
- codegen file layout container
- inputs:
	- signing
	- intents
	- etc

## Build
- some rebuilds the Build container so its indempotent and has concise API as it were.
- xlab has some nice command line packaging code to avoid having to jump into Android Studio and XCode.

## Laxout / Reflow
The "core" of the GUI takes care of lay-outing and positioning.  
And, you can create your own little widgets easily, while the "core" takes care of that lay-outing and positioning.

Needs concept of scrollable area and docks too. Even a basic TextBox needs scrolling.

https://gist.github.com/htrob/7eddea79a8dbe673e5b4d0bb048726b0
https://github.com/gen2brain/raylib-go/tree/master/raygui

## Widgets
These stand on their own.

Basic set of course.
Text Editor is the hard one as getting layout and scrolling working well is tough.


