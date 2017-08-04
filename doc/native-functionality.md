# Key Native Functionality

These are things needed for a Desktop / Mobile application to be decent quality. 

Most of the work is just a matte of golang wrapping the correct c code and refactoring it in.

These are in order of the need.

## Window

### Where is the GLCanvas ??? Shiny is the core
dskinner versus ebiten versus xlab ?

Basically SHINY is a failure because you cant control the blooody glcanvas on mobile properly.
THis is why ebiten and xlab both use the Native OS glcanvas

https://github.com/xlab/android-go/tree/master/app

https://github.com/hajimehoshi/ebiten
- ebiten uses a glcanvas at the java and objective c level for mobile and then glfw for desktop.
- dskinner is using Shiny. But how to sign his code because he is using gomobile build, rather than gomobile bind ?

### Shaders 


## Input - Keys, Touches, Gesture determination
This is the core start of any app, because you need a Window and then key & touch events. 

https://github.com/hajimehoshi/ebiten
- Works on Desktop, Mobiles and Web.


## Virtual keyboard
On mobile the user touches in an openGL TextBox, and the virtual keyboard should come up.

xlab has Android code working :)
- https://github.com/xlab/android-go/blob/master/android/jni_util.go


## Cut and paste
On Mobile, the user needs to cut and paste text in a TextBox.
On Desktop, the same, but also the CONTROL keys also work.

Printing/Scanning
Ability to send documents to the Printer.

https://github.com/aarzilli/nucular/tree/master/clipboard
Works well on Desktops

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
