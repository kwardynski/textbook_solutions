defmodule Stack.Application do
  use Application

  def start(_type, initial_list) do
    {:ok, _pid} = Stack.Supervisor.start_link(initial_list)
  end
end
