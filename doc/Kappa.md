# Kappa

The sytem from top ot bottom is a real time stream processing system.
It uses go-micro as a basis because its so mature, and because go-micro is independent of the architectural patterns ou apply.

TODO: Diagram

## Stack View

- Shared
	- This is for things shared across all systems
	- Types are used everywhere and are based on protocol buffers.

- GUI
	- This is built with opengl because it allows the same code to be used to build all clients.
	- Client types
		- Web Browser
			- WebGL based
		- Desktop
			- OpenGL based on glfw
		- Mobile
			- Opengl based on opengl surface at native level
		- Webview
			- There is a future path of also using WebUViews on all Desktops and Mobiles.
			- This is possible due to the interop that the opengl already uses.
	- DB
		- The web does not need a DB, but the Desktop and Mobile do. The reasoning here is that for uses cases where offline is not required usrs just use the web Browser, but for situations where they do need offline then then use a Desktop or Mobile client.
		- Its the exact same DB that the Server uses. This is because it allows reuse of so much code and avoids bugs. Its DRY basicaally
		- 

- Reverse Proxy
	- Supports different transports like https, websockets (WSS), server sent events (SSE), quic
		- Need different transports fro different use cases:
			- Load a ton of data, uses Http Request
			- Get updates, using websockets or SSE
			- Stream audio video uses QUIC.
	- Support Transport crypto
		- Can use whatever you want here for over the wire crypto
	- Support Authentication / Authourisation
	- Tracing
	- Metrics
	- Contextual Query
		- Clients (be they ours or other parties) need data from use but shaped in a different shape to what we may have them.
		- THis is essentialyl just a graphQL based search system.
		- Note that mutations are modelled here and are converted to events on the Control plane.
		- This maintains a "Chinese Wall" in terms of data structures between the External and Internasl systems.

- ETL Layer
	- The types that we may use and those that others may know vary.
	- Also all systems need a decent ETL system.
	- What this really does is use the Kappa architecture of the Control Plan and Services (materialsIsed views) in order to perform transformation.
	- Each transformation is written as a standard rolang routine.
		- As data is being walked, the system can then fire events out to other Transformation routines
		- Each has a DB state.

- Client Mailbox
	- Clients that run offline need to catchup to mutations they missed.
		- The best way to understand this is to understand that a Service is global scoped and a Mailbox is user scoped.
		- The Control plane could be used for this but its a leaky abstraction as the Control plane has no idea about what data a user has. Also a user might be using 3 devices each in a different state of offline in terms of catching up on the mutations. So there is a Mailbox per UserDevice in reality.
	- The mail box subscribes to a topic on the control plane for anything that is relavant to them.
	- You can also have mailboxes for third party system.
	- Companies end up building a myriad of Client Apps for different reasons, and so a mailbox is a great abstraction because you can have one for Client App also.
	
- Control Plane
	- This is a Message queue that stores all messages for ever. It is the only thing that must be backed up, which is easy because its just a log.
	- All Services use this for communication. 	- It divides the North / South and East / West communications also.
	- Supports Backend by asynchrously sending to a Storgae node like S3 or Google Storage.
	- Supports dynamic topics and channels, so that services can use it at will.
	- This is the heart of the Kappa Architecture. 
		- When as events come in from Clients (north), Other Third Parties (East West), Our Services (South) these are forwared to any system that subscribes to them.
		- Any system (North, SOuth, East, West) can subscribe to events in order for it to do its procesing.
		- The easiest way to think about it is a global database where a table is a service and forign keys and their data are maintained vis the triggers transposed as events.
		- Its a Choreopgraph based sytem, in that its is emergent. This means that you can add a new bit of functionaloty to the system by just making it ans then subscribing to the Control plane and its events. You dont have to change any existing systems. This leads to the ability to maintain old systems and no heavy refactoring or techncial debt buidl up.
	

- Service(s)
	- These are simple golang routne ans nothing more.
	- This allows 100's of services to be run on 100's of servers or 1 mobile phone. This makes development much easier.
	- The data each holds are really Materialised Views of the data from the Control plane.

- Infra
	- Each service needs the same things:
		- DB using bolt DB
		- Structured Text indexing using Bleve
		- Unstructured text using Pilosa.
		- File Storage using Minio