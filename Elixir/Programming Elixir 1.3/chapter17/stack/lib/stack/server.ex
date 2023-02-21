defmodule Stack.Server do
  use GenServer


  ## ================================================================== ##
  ## External API
  ## ================================================================== ##

  def start_link(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack, name: :Stack)
  end

  def pop do
    GenServer.call(:Stack, :pop)
  end

  def push(item) do
    GenServer.cast(:Stack, {:push, item})
  end


  ## ================================================================== ##
  ## GenServer Implementation
  ## ================================================================== ##

  # Pop Implementation: When given a list, replies with head and
  # passes tail as the new state.
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_call(:pop, _from, []) do
    {:stop, :empty_list, []}
  end

  # Push Implementation: Appends an item to a list, returns
  # that as the next GenServer state
  def handle_cast({:push, item}, list) do
    {:noreply, [item | list]}
  end

  # Terminations
  def terminate(reason, state) do
    IO.puts(
      ":Stack Terminated!\n \
      \tReason:\n \
      \t\t #{inspect reason}\n \
      \tState:\n \
      \t\t #{inspect state}")
  end

end
