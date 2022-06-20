defmodule Sequence.Server do

  # Sequence worker has two changes:
  #   1. When it is initialized, it must get the current number from the stash
  #   2. When it terminates, it stores the then-current number back in the stash.
  # To make these changes, override the 'init' and 'terminate' GenServer callbacks


  # The following line adds the OTP GenServer behavior to our module
  # This is what lets us handle all the "namespace" callbacks
  use GenServer

  ## ================================================================== ##
  ## External API
  ## ================================================================== ##

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment_number, delta})
  end


  ## ================================================================== ##
  ## GenServer Implementation
  ## ================================================================== ##

  def init(stash_pid) do
    current_number = Sequence.Stash.get_value stash_pid
    {:ok, {current_number, stash_pid}}
  end

  def handle_call(:next_number, _from, {current_number, stash_pid}) do
    {:reply, current_number, {current_number+1, stash_pid}}
  end

  def handle_cast({:increment_number, delta}, {current_number, stash_pid}) do
    {:noreply, {current_number+delta, stash_pid}}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end

  def terminate(_reason, {current_number, stash_pid}) do
    Sequence.Stash.save_value stash_pid, current_number
  end

end
