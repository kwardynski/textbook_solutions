defmodule Stack.Stash do
  use GenServer

  #####
  # External API

  def start_link(current_list) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, current_list)
  end

  def save_list(pid, list) do
    GenServer.cast pid, {:save_list, list}
  end

  def get_list(pid) do
    GenServer.call pid, :get_list
  end


  #####
  # GenServer Implementation

  def handle_call(:get_list, _from, current_list) do
    {:reply, current_list, current_list}
  end

  def handle_cast({:save_list, list}, _current_list) do
    {:noreply, list}
  end

end
