# go-gu docs

There is a hell of a lot of reinventing the wheel going on with GUI 6 Data systems.
My take..

## Emergent Design ("EDesign")
Its all a Unidirectional DAG, and if you build everything this way then the data driving the GUI (layout, size, etc etc) will resolve from that.
Thsi is how a database with MaterialiseViews works. There is a reasom its called a "Materialsied View". Its because its as a result of rela time changes to a number of other Tables of data that resulted in new data in the Materialised View.
SO the exact same logic can be applied to all the property of a GUI and all its Widgets, and turltes all the way down.

BTW Materialised VIews result in immutable data, which overcomes the other problem of all systems, including GUI's have. 

Golang channels are a pretty good way to build the pipes between everything.

Mutations are then inputs that hit Tables and then lots of triggers fire through pipes to alter Materialised Views. YOu can replace Tables with Structs and Materialsied VIews with GUi VIews and its a GUI !

At the end of the day this is how you build GUI, Analytics engines, really anything.

A paradigm that has already done this is Grasshopper.
Each golang chanel has a struct that represents data. 
In a DB scenario, change to a table emit the change to all subscribing Table,s and they update their own data structues.
The same is true for anything else dependnet on that data, such as a GUi View.
Is that GUI View requires a mix of data from different views then you need to make a Materialisd View just for that GUI View
This GUI View subscribed to what it needs. And so it goes.

### Bigger than a single machine ?
In this case a golang channel has a Namespace. The Message queue creates a topic automatically, and any other golang channels subscribe to its messages.
Its really just the same cognitive model except that a message queue is there.


### Lavout: Print 6 Screen & VR
Because everything is 100% driven by data, you can implement any layout feature you want.
Print Media and Browser media are nwo the same. 
Everything is also a vector. We do not use images. Just like SVG, but much more low level.
After all the DAG can also do anything to the primitives.

At the start everything is just sitting there stacked on top of each other at 0,0 :)
Now what ? How to get started ?

https://godoc.org/gomatcha.io/matcha/layout
- golang layout constrainst

https://github.com/kjk/flex
- pure go port of FLexbox. 

https://en.wikipedia.org/wiki/Cassowary_(software)

github.com/gonum/gonum
- has simpex methods that do what cassowary does.

Vecty
- great example: https://github.com/iafan/goplayspace
- Use vectry as the main component system for ebiten ! Might work to bring it all togehter.
	- It is mapped to a DOM. But ebiten does not have a dom. hmmm...

Gonum
- https://github.com/gonum/gonum
- Good place to write a simplex solver that solves layout !!!



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

### Constraint solvers
This is a generic layout solution.
Boxes can be controlled by associating variable betwen thenings.

https://github.com/cpmech/gosl
- This is the most advanced
- Have structures for 2d and 3D. Has NUrbs !
- Has a solver
	- https://github.com/cpmech/goga


http://marvl.infotech.monash.edu/webcola/
- designed for layout in the browser
- Its impressive and makes a fantastic case.
- Can be used for the IDE node layout.
- http://marvl.infotech.monash.edu/~dwyer/
	- examples of use cases. Many similar to mine.
	- One biggy is the IDE aspect
- This whole area is related to a Directed Graph.
	- Seems to be the core of ti.

https://github.com/irifrance/gini
- SAT generic solver



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

## MQ

github.com/micro/go-micro
- Has enough MQ ans streaming to be useful.
- Might as well use this as a basis.
- https://github.com/micro/go-os
	- Its a client library for 

Vice 
- golang structs pumped in and out of a MQ. 
- Perfect abstraction
- Perfect for a constrainst system too as it can tap into the MQ
- Topics are Views that resolve out of the system.
- IPFS PUBsub might be a good one too. Using IPFS itslef as the MQ :)
	- github.com/libp2p/go-floodsub


Transports / Protocols
- So we need a way to PUSH and some of this data is highly time window constrained like Video.
- We could just use QUIC for everything, but we shoudl probably have an abstraction.
- So lets use libp2p based on IPFS.
- IPFS is like a global FS, and so it makes sense to use this too as its like a poor mans SAN.

Plan 9
- In this system everything is expoed a as a File system.
- Its great because it goes al the way down to OS processes or really anything.
- SO what we do is epose the 9P stuff over Vice !!!
- http://doc.cat-v.org/plan_9/3rd_edition/rio/rio_slides.pdf
	- Using 9P for a GUI :)
	- Expsose everything

## Data Resolution
How to haev 2 types in two places at the same time ?
Needed for offline editting
https://ipfs.io/blog/30-js-ipfs-crdts/
https://github.com/ipfs-shipyard/shared-editing-demo
- Shows the bais of it, but its fucking JS
- SO lets adapt it using leaps
	- https://github.com/Jeffail/leaps



## DB

We need a DB

https://github.com/cznic/ql
- SQL absed and so everyone knwos it.

Then we need Text Search
- Bleve

Ten we need unstructured search
- Pilosa

