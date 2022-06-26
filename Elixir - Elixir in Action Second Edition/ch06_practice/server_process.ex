# Module outlining the abstraction for the GenServer (generic server) functionality in Elixir
defmodule ServerProcess do


  # Takes a module atom as the argument and then spawns the process
  # In the spawned process, the callback function init/0 is invoked to create
  # the initial state.
  def start(callback_module) do
    spawn(fn ->
      initial_state = callback_module.init()    # <-- invokes the callback to initialize the state
      loop(callback_module, initial_state)
    end)
  end


  defp loop(callback_module, current_state) do
    # A message is expected in the form of a {request, caller} tuple.
    receive do
      {request, caller} ->
        {response, new_state} = callback_module.handle_call(request, current_state)   # invokes the callback to handle the message
        send(caller, {:response, response})                                           # sends the response back to the caller
        loop(callback_module, new_state)                                              # loops with the new state
    end
  end


  def call(server_pid, request) do
    send(server_pid, {request, self()})   # sends the message
    receive do
      {:response, response} ->            # waits for the response
        response                          # returns the response
    end
  end

end


# KeyValueStore wrapping ServerProcess function calls
defmodule KeyValueStore do
  def start do
    ServerProcess.start(KeyValueStore)
  end

  def put(pid, key, value) do
    ServerProcess.call(pid, {:put, key, value})
  end

  def get(pid, key) do
    ServerProcess.call(pid, {:get, key})
  end
end


defmodule KeyValueStore_v1 do

  # Initializes an empty state (map) used for the key value store
  def init do
    %{}
  end


  # Handles the "put" request
  def handle_call({:put, key, value}, state) do
    {:ok, Map.put(state, key, value)}
  end


  # Handles the "get" request
  def handle_call({:get, key}, state) do
    {Map.get(state, key), state}
  end

end
