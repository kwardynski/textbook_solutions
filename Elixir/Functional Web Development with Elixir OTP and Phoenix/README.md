# Functional Web Development with Elixir, OTP, and Phoenix

I'll be ending the book halfway through Chapter 7.\
The Phoenix channel/socket sections are well out of date by this point, and we're not actually building the front end (which is what I was hoping to get out of the book in the first place.)

## Part I - Define the Functional Core in Elixir

### [Chapter 2 - Model Data and Behavior](Chapter02/)
- Structs maintain all the qualities of maps, however they offer compile-time checks on the keys, and allow us to do run-time checks on the struct's type.
- the `@enforce_keys` attribute can be used to ensure that all listed keys are present when creating a new struct.

### [Chapter 3 - Manage State with a State Machine](Chapter03/)
- In this chapter, we build a state machine from scratch in `IslandsEngine.Rules` using multiple function heads to handle transitions from current to next allowable state. 
- We did this in a way that's completely decoupled from any other modules written so far and kept is separate from the application's "business logic". 

## Part II - Add OTP for Concurrency and Fault Tolerance

### [Chapter 4 - Wrap It Up in a GenServer](Chapter04/)
- The Erlang `:sys` module provides a `get_state/1` function which returns the state of a `:gen_server` process - **THIS IS NOT INTENDED FOR PRODUCTION CODE, USE FOR EXPLORING/DEBUGGING**

### [Chapter 5 - Process Supervision for Recovery](Chapter05/)
- Elixir and OTP provide process supervision - meaning we can have specialized processes to watch other processes and restart them if/when they crash.
- In Elixir, we have the supervisor "Behaviour" which extracts error handling code from the business logic into it's own modules. These modules spawn supervisors which link to other processes and watch for failures, then re-start linked processes if they crash.
- Supervisor Behaviour is based on the principles that:
    - Most runtime errors are transient and happen because of bad state.
    - The best way to fix a bad state is to let the process crash and re-start with a good state.
    - Restarts work best on systems that have small, independent processes. This allows error isolation to the smallest area possible, minimizing the disruption caused by a restart.
- In Elixir, the approach to error handling is _not_ to anticipate specific errors, but to have tools which allow us to gracefully recover from all errors if/when they happen.
- Supervisors have different restart options for handling crashes:
    - One for One: If a single process terminates, the supervisor will restart just that one process. This is best to use if the group of supervised processes can work independently of each other.
    - One for All: If a single process terminates, the supervisor will restart **all** of it's children. This strategy is best if the group of supervised processes depend on each other, and each other's state, to work properly.
    - Rest for One: If a single process terminates, the supervisor will restart the processes that start _after_ the failed process, in the order they initially were started in. This strategy is best to use for groups of processes that have a temporal dependence, meaning that newly spawned processes depend on the processes, and the state of those processes, started before them.
    -Simple One for One: Similar to One for One, except if an _individual_ process terminates, the supervisor will restart just that one process. 
- ETS tables (Erlang Term Storage) are a storage engine that ships with OTP. These allow us to store data in-memory as two-element tuples (key, value).
    - We can initialize one of four ETS table types:
        - :set -> tables that store exactly one value per key.
        - :ordered_set -> tables that store exactly one value per key _in order_.
        - :bag -> tables that can store multiple values under the same key, as long as the values are not exact duplicates.
        - :duplicate_bag -> tables that can store multiple values under the same key, even if they are exact duplicates.
    - ETS tables come with three levels of privacy:
        - :private -> only the process which initialized the table can read or write from it.
        - :protected (default) -> all process can read from the table, however only the process that started it can write to the table.
        - :public -> all processes have read and write access to the table, regardless of which process started it.

## Part III - Add a Web Interface with Phoenix

### [Chapter 6 - Generate a New web Interface with Phoenix](Chapter06/)
- Coupling: It is best practice to separate business logic from frameworks/interfaces. 
- Phoenix is NOT your Application: We are not building a Phoenix app, we are building a game which uses Phoenix as the web framework! It is important to think in these terms to help mentally (and programatically) separate the business domain from the web domain.
- Decoupling: We are going to _layer on_ our web interface, such that it will live _alongside_ our game engine - ensuring the two are sufficiently decoupled such that we can re-use our business logic with other frameworks/interfaces.

### [Chapter 7 - Create Persistent Connections with Phoenix Channels](Chapter07/)
- Channels provide (safe and scalable) persistent connections between stateful servers and stateful clients.
- Channels can support bidirectional messaging on many topics.
- The components of a Channel:
    - Socket: `Phoenix.Socket` - A custom behavior for establishing and maintaining the connection between clients and channels.
    - Transport: Transport layer moves messages between the client and server.
    - Phoenix PubSub: A method by which clients register to a channel in order to receive published messages.
    - Presence: Tracks channel membership (including across multiple nodes in a distributed cluster)
    - Clients


    