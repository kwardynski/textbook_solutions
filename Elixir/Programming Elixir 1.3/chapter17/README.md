# CHAPTER 17 - OTP: Servers

- OTP: _Open Telecom Platform_. Initially used to build telephone exchanges and switches. In Elixir, OTP
  is now a general-purpose tool for developing and managing large systems.
- OTP defines systems in terms of hierarchies of _applications_. An application consists of
  one or more processes. These processes follow one of a small number of OTP conventions,
  called _behaviors_. 


## Problems:

1. You're going to start creating a server that implements a stack. The call 
   that initializes your stack will pass in a list of the initial stack contents.
   For now, implement only the `pop` interface. It's acceptable for your server
   to crash if someone tries to pop from an empty stack.
   For example, if initialized with `[5, "cat", 9]`, successive calls to `pop` 
   will return `5`, `"cat"`, and `9`.

   ```
   Solution "application" is going to live in the "stack" directory.
   The handle_call function defined in lib/server.ex is going to handle the pop functionality
   ```


2. Extend your stack server with a `push` interface that adds a single
   value to the top of the stack. This will be implemented as a cast./
   Experiment in iex with pushing and popping values

   ```
   Stack.Server.handle_cast({:push, item}, list)

   iex(1)> {:ok, pid} = GenServer.start_link(Stack.Server, ["initial", "list"])
   {:ok, #PID<0.160.0>}

   iex(2)> GenServer.call(pid, :pop)
   "initial"

   iex(3)> GenServer.cast(pid, {:push, "odd"})
   :ok

   iex(4)> GenServer.call(pid, :pop)
   "odd"
   ```


3. Give your stack server process a name, and make sure it is accessible by
   that name in iex.

   ```
   def start_link(initial_stack) do
       GenServer.start_link(__MODULE__, initial_stack, name: :Stack)
   end

   iex(1)> Stack.Server.start_link(["first", "second", "third"])
   {:ok, #PID<0.160.0>}

   iex(2)> GenServer.call(:Stack, :pop)
   "first"   
   ```


4. Add the API to your stack module (the functions that wrap the GenServer
   calls)

   ```
   def pop do
       GenServer.call(:Stack, :pop)
   end

   def push(item) do
       GenServer.cast(:Stack, {:push, item})
   end
   ```


5. Implement the `terminate` callback in your stack handler. Use `IO.puts` to report the arguments it receives.\

   Try various ways of terminating your server. For example, popping an 
   empty stack will raise an exception. You might add code that calls 
   `System.halt(n)` if the `push` handler receives a number less than 10. (This will
   let you generate different return codes.) Use your imagination to try different
   scenarios.

   ```
   I'm just going to throw in a terminate call into the pop version of handle_call when attempting to pop from an empty list
   ```