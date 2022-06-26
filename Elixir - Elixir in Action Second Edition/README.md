# Chapter 1 - First steps
- I/O operations are internally delegated to separate threads in Erlang, therefore any process that waits for an I/O operation to finish won't block the execution of other processes.
- Why use Elixir over Erlang? Elixir presents cleaner, more compact code which does a better job of revealing the process's intentions. Programs written in Elixir will be compiled and executed in BEAM.
- Since Elixir/Erlang run on BEAM, programs will never achieve the speed of machine-compiled code (C/C++). The goal isn't maximizing performance, instead the focus is to keep performance as predictable, reliable, and fault-tolerant as possible.



# Chapter 2 - Building Blocks 
- Everyting in Elixir is an expression that has a return value. This extends to constructs such as `if` and `case`.
- Elixir is dynamically typed -> the variable type is determined by the data which it contains at the moment.
- In Elixir, assigning a value to a variable is called _binding_.
- Data is immutable - once a memory location is occupied with data, it cannot be modified until that memory address is purged. Variables, however, can be re-bound. This simply makes them point to a different memory location. **Variables are mutable, data is immutable**.
- Elixir has automatic garbage-collection. This means memory does not have to be manually released. When a variable goes out of scope, the corresponding memory will be released sometime in the future.
- Tuples are most appropritae for grouping small, fixed number of elements together. Use lists for larger, dynamically sized collections.
- In Elixir, lists might _look_ like array from other languages, however they behave like singly-linked lists. Most of the operations on lists have O(n) time complexity (including getting the length of a list), therefore are not a good fit when direct access is called for.
    - When you modify the _n_th element of a list, the new version will contain shallow copies of the first _n_-1 elements, followed by the modified element. Ater that, the tails are completely shared. This is why adding elements to the end of a list is expensive in Elixir. To append a new element at the tail, you have to iterate and copy the entire list.
- Sigils can be useful for quick formatting of strings. The `~s` sigil allows you to include quotes without escape characters, and `~S` does not handle interpolation or escape characters:
```
iex(1) > ~s("Do... or do not. There is no try." - Master Yoda)
"\"Do... or do not. There is no try.\" - Master Yoda"

iex(2) > ~S(Not interpolated: #{3 + 0.14}\n)
"Not interpolated: #{3 + 0.14}\\n"
```



# Chapter 3 - Control flow
No notes taken for this chapter, however solutions to practice problems can be found [here](./ch03_practice/)



# Chapter 4 - Data abstractions
The basic principles of data abstraction in Elixir:
- A module is in charge of abstracting some data.
- The module's functions usually expect an instance of the data abstraction as the first argument.
- Modifier functions return a modified version of the abstraction.
- Query functions return some other type of data.

**Structs vs Maps**  
Structs are really just implementations of maps, so they have the same characteristics with respect to performance and memory usage. Struct instances, however, receive a slightly special treatment - i.e. they _are not_ enumerable so you can't call `Enum` functions on them. Struct patterns also _cannot_ match a plain map, however a plain map _can_ match a struct!  

**Data Transparency**
In Elixir, data is _always_ transparent. Unlike traditional OO languages, clients can read all of the data in your structs (or any other data type for that matter). In this sense, encapsulation works differently in Elixir than you may be used to.

### Summary:
- A module is used to create a data abstraction. A module's functions create, manipulate, and query data. Clients can inspect the entire structure but shouldn't rely on it.
- Maps can be used to group different fields together in a single structure.
- Structs are special kind of maps that allow you to define data abstractions related to a module.
- Polymorphism can be implemented with protocols. A protocol defines an interface that is used by the generic logic. You can then provide specific protocol implementations for a data type.



# Chapter 5 - Concurrency primitives
**Covered in this chapter:**
- Understanding BEAM concurrency principles
- Working with processes
- Working with stateful server processes
- Runtime considerations

Concurrency in BEAM (and Erlang) tackles to following challenges:
- _Fault-tolerance_ - Minimizee, isolate, and recover from the effects of runtime errors.
- _Scalability_ - Handle a load increase by adding more hardware resources without changing or redeploying code.
- _Distribution_ - Run your system on multiple machines so that others can take over if one machine crashes.

**NOTE**:
```
Concurrency doesn't necessarily imply parallelism. Two concurrent things have
independent execution contets, but this doesn't mean they will run in parallel. 
If you run two CPU-bound concurrent tasks and you only have one CPU core, parallel 
execution can't happen. You can achieve parallelism by adding more CPU cores
and relying on an efficient concurrent framework. But you should be aware that
concurrency itself doesn't necessarily speed things up!
```

### Summary:
- A BEAM process is a lightweight concurrent unit of execution. Processes are completely isolated and share no memory.
- Processes can communicate with asynchronous messages. Synchronous sends and responses are manually built on top of this basic mechanism.
- A server process is a process that runs for a long time (possibly forever) and handles various messages. Server processes are powered by endless recursion.
- Server processes can maintain their own private state using teh arguments of the endless recursion.



# Chapter 6 - Generic server processes
Elixir provides comprehensive framework for implementing server processes: OTP (Open Telecom Platform). It provides patterns and abstractions for tasks such as creating components, building releases, developing server processes, handling and recovering from runtime errors, logging, event handling, and upgrading code. All code that implements a server process needs to do the following:
- Spawn a separate process
- Run an infinite loop in the process
- Maintain the process state
- React to messages
- Send a response back to the caller

In the [server_process](/ch06_practice/server_process.ex) file, clients can use `start/0`, `put/3`, and `get/2` to maniupulate the key/value store. These functions are informally called _interface functions_. Clients use the interface functions of `KeyValueStore` to start and interact with the process. In contrast, `init/0` and `handle_call/2` are callback functions used internally by the generic code. Note that interface functions run in the client processes, whereas callback functions are always invoked in the server process.

**Supporting Asynchronous Requests**
In OTP, the naming convention for synchronous requests is _call_, while the naming convention for asynchronous requests is _cast_. 

## Using GenServer
Elixir ships with support for building generic server processes, called _GenServer_. Some of the compelling features of _GenServer_ are:
- Support for calls and casts
- Customizable timeouts for call requests
- Propagation of server-process crashes to client processes waiting for a response
- Support for distributed systems

### Summary
- A generic server process is an abstraction that implements tasks common to any kind of server process, such as recursion-powered looping and message passing.
- A generic server process can be implemented as a behaviour. A behaviour drives the process, whereas specific implementations can plug into the behavior via callback modules.
- The behaviour invokes callback functions when the specific implementation needs to make a decision.
- _GenServer_ is a behaviour that implements a generic server process.
- A callback module for _GenServer_ must implement various functions. The most frequently used ones are `init/1`, `handle_cast/2`, `handle_call/3`, and `handle_info/2`.
- You can interact with a _GenServer_ process with the _GenServer_ module.
- Two types of requests can be issued to a server process: calls and casts.
- A cast is a fire-and-forget type of request - a caller sends a message and immediately moves on to do something else.
- A call is a synchronous send-and-respond request - a caller sends a message and waits until the response arrives, the timeout occurs, or the server crashes.



# Chapter 7 - Building a concurrent system
Some preferred conventions for file naming and organization in Elixir (Mix) projects:
- You should place your modules under a common top-level alias. For example, modules might be called `Todo.List`, `Todo.Server`, and so on. This reduces the chance of module names conflicting when you combine multiple projects into a single system.
- In general, one file should contain one module. Occasionally, if a helper module is small and used only internally, it can be placed in the same file as the module using it. If you want to implement protocols for the module, you can do this in the same file as well.
- A filename should be an underscore case (aka _snake_ case) version of the main module name it implements. For example, a `TodoServer` module would reside in a todo_server.ex file in the lib folder.
- The folder structure should correspond to multipart module names. A module called `Todo.Server` should reside in the file /lib/todo/server.ex

### Summary
- When a system needs to perform various tasks, it's often beneficial to run different tasks in separate processes. Doing so promotes the scalability and fault-tolerance of the system.
- A process is internally sequential and handles requests one by one. A single process can thus keep its state consistent, but it can also cause a performance bottleneck if it serves many clients.
- Carefully consider calls versus casts. Calls are synchronous and therefore block the caller. If the response isn't needed, casts may improve performance at the expence of reduced guarantees, because a client process doesn't know the outcome.
- You can use `mix` projects to manage more involved systems that consist of multiple modules.




