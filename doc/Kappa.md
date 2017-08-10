# Kappa

The sytem from top ot bottom is a real time stream processing system.
It uses go-micro as a basis because its so mature, and because go-micro is independent of the architectural patterns ou apply.

TODO: Diagram

## Concept


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
	- What this really does is use the Kappa architecture of the Control Plan and Services (materialsised views) in order to perform data transformation.
	- Each transformation is written as a standard rolang routine.
		- As data is being walked, the system can then fire events out to other Transformation routines
		- Each has a DB state.
	- At the End your data is in the right shape and can be sent into the Global system as required using the Mutations API.
		- This can be done in a batched or streaming fashion too.

- Client Mailbox Control plane
	- Clients that run offline need to catchup to mutations they missed.
		- The best way to understand this is to understand that a Service is global scoped and a Mailbox is user scoped.
		- The Control plane could be used for this but its a leaky abstraction as the Control plane has no idea about what data a user has. Also a user might be using 3 devices each in a different state of offline in terms of catching up on the mutations. So there is a Mailbox per UserDevice in reality.
	- It is in essence a Control Plane Proxy just for a User and all its devices, but
		- It does not need to be backup because all data here originated from the main control plane.
		- You can spread these on as many servers as you need or put them in cold storage.
		- They all have infra (data, files), but not indexes because these are calculated on the Client device.
		- As a Client catches up, this store is smaller. Its really just a cache.
	- The mail box subscribes to a topic on the control plane for anything that is relavant to them.
		- A Client and what Components is uses must be known, so that the Mailbox control plane knows what mutations it must subscribe to.
		- This can be discoverded based on what queries it makes, so its a simple Discovery pattern.
	- You can also have mailboxes for third party system too. They are just clients.
	- Companies end up building a myriad of Client Apps for different reasons, and so a mailbox is a great abstraction because you can have one for Client App also.
	- You can also do data transformation here in obth directions as needed.
		- For example a User Device A is on Version 1, but Device B is on Version 2.  
	- This also allows subscription use cases like twitter, etc etc
	- Great for CDN btw, because you can have these in 10 datacenters, and when a client synchronises you can then tell the others data centers mailboxes to delete down to sequecne number X.


- Control Plane
	- This is a Message queue that stores all messages for ever. It is the only thing that must be backed up, which is easy because its just a log.
	- All Mutations MUST have:
		- DateTime (gmt)
		- Actor (client name)
		- Verb (what they are doing)
		- Thing (the data)
			- If it is allot of data (like a binary image), then it should go in a global binary store, and a ref UUID should be the thing.
			- Minio is a decent binary store btw
	- The Mutation type IS the indempotency. If the system sees the same mutation is ignores it.
	- Consistency: CRDT Roshi Set provides a Last writer wins pattern
		- Ref: https://www.youtube.com/watch?v=em9zLzM8O7c
		- Code. https://github.com/soundcloud/roshi
		- Need to try this pattern out.. Loosk old but still good.
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

	- Analytics needs a special note.
		- This system is not a OLTP pr OLAP system in the same way that its not a batch system versus a streaming system.
		- It is all those things because it is steaming and forwarding only and so can do all the above things.
		- So all Metrics, Analytics etc can be just another Service and a Materilised View.
		- This also makes it remarkable for machine learning because you can build up views, but can also throw the data away fix your logic and then replay the data back in.

- Infra
	- Each service needs the same things:
		- DB using bolt DB
			- https://github.com/eliquious/tinytable
				- replicated BoltDB
		- Structured Text indexing using Bleve
		- Unstructured text using Pilosa.
		- File Storage using Minio
	- Each infrastructure can be replicated using Raft with no complex locking needed.
		- This is a simpel leader / election protocol.
		- In addition You can use a control plane also for relationships between each
	- Consol and Service Discovery 
		- So everything is emergent and can discover each other.

- Common NameSpace
	- This is really just a plan9 architecture for descibing everything as types and foldrs of a file system.
	- The FS does not exist, but its an abstraction for systems to talk to each other.

## What this enables ?

- Infintie scaling and ability to have highest possible SLA. Your essentially procomputing the Views ahead of time.
	- Within a Materialised view you can do normal searches, but there is no point doing a join because this has alreads been done.
- Caching at the network edge all the way out to Clients.
	- This archietcture is fractal in that it is self similar. You can have Mailbox of mailboxes at any point in the network because its is essentially a store and forward system.
- If you have a bug in your logic anywhere, you can delete your databases and then replay back from the Control plane.
	- This makes a developer fixing bugs much easier
	- On Production you can put a hotfix in, rebuild your data and swap it in when its done. This can all happen whilst Production is running.

# Time / Space issues
- You want a global sequence for all mutations so that you have ordering.
 - For offline clients this means that they need a sequence in their mailbox that is linked to the global sequence.
 - CRDT Counter