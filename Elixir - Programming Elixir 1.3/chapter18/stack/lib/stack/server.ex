defmodule Stack.Server do
  use GenServer


  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end


  def init(stash_pid) do
    current_list = Stack.Stash.get_list stash_pid
    {:ok, {current_list, stash_pid}}
  end

  def handle_call(:pop, _from, {[head | tail], stash_pid}) do
    {:reply, head, {tail, stash_pid}}
  end

  def handle_cast({:push, item}, {list, stash_pid}) do
    {:noreply, {[item | list], stash_pid}}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end

  def terminate(_reason, {list, stash_pid}) do
    Stack.Stash.save_list stash_pid, list
  end

end
