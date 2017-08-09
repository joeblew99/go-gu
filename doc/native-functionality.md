# Key Native Functionality

These are things needed for a Desktop / Mobile application to be decent quality. 

Most of the work is just a matte of golang wrapping the correct c code and refactoring it in.

These are in order of the need.

## Window

### Where is the GLCanvas issues ??? 
dskinner versus ebiten versus xlab ?

Basically SHINY is a failure because you cant control the blooody glcanvas on mobile properly.
THis is why ebiten and xlab both use the Native OS glcanvas

https://github.com/xlab/android-go/tree/master/app

https://github.com/hajimehoshi/ebiten
- ebiten uses a glcanvas at the java and objective c level for mobile and then glfw for desktop.
- dskinner is using Shiny. But how to sign his code because he is using gomobile build, rather than gomobile bind ?


https://github.com/gomatcha/matcha
- This is easily the most mature and promising.
- Everything is done is golang, and there is a small bridge over PB's to hook into UIKit.
	- The UIKIt controls are only instantiated. All control of them is at golang level.
	- SO the PB's provide a two way communication over a relay network (or some kind).
- What's in it for us ?
	- Its really just a remote way to build a UIKIT app. 
	- But the way it hooks into Keyboard is great: https://github.com/gomatcha/matcha/blob/master/keyboard/keyboard.go
		- We can use this bridge technque for All other OS's as a pattern.
		 



### Shaders 


## Input - Keys, Touches, Gesture determination
This is the core start of any app, because you need a Window and then key & touch events. 

Shiny and Ebiten have this mostly working..

https://github.com/hajimehoshi/ebiten
- Works on Desktop, Mobiles and Web.


## Virtual keyboard
On mobile the user touches in an openGL TextBox, and the virtual keyboard should come up.
You type and the text typed is forwarding back into the openGL Textbox.

When the virtual keyboard opens, the openGl canvas MUST be moved up so that the TextBox stays in view. 
This is a huge problem that occurs when using a webview.


xlab has Android code working :)
- https://github.com/xlab/android-go/blob/master/android/jni_util.go


## Cut and paste
On Mobile, the user needs to cut and paste text in a TextBox.
On Desktop, the same, but also the CONTROL keys also work.


https://github.com/aarzilli/nucular/tree/master/clipboard
Works well on Desktops

## Printing/Scanning
This means that when the user presses a PRINT button (that you Or the Mobile OS provides), you just run a PDF template for the print size selected.
We dont want to try to print the actual screen from the openGL Canvas at this stage (this can do it though: https://github.com/llgcode/draw2d) 

There are a few aspects to this. Each one is part of the pipeline.

Step 1 - Ability to Bring up Native Printer dialog.
- Google has code for this for Desktop...
- We want to know the Paper size so we can move into Step 2.


Step 2 - Ability to output to a printable format. 
- For now have a PDF Template in golang is good enough for now.
- The template is modified based on the Page size the user chooses.


Step 3 - Ability to send documents to the Printer.
- Some magic c code :)




## Audio and Video capture and playback
Existing Libs
Audio
https://github.com/hajimehoshi/oto

## Sharing
You are in an app page and click “Share”, and the OS brings up all apps that handle that intent.

## Notifications
2 use caes
- From within the app you wish to raise a native notification.
- You raised a notification from the Server via the mobile push gateways and the user has pressed on it in their Notifications bar, and it routes down into the right part of the App.

## Web Linking
So that web links passed are routed to the correct location within the app.
Use case:
- You send a http link to a friend and he has the app for it and so it opens the app, and navigates into the app to the right location. Google maps does this for instance.
