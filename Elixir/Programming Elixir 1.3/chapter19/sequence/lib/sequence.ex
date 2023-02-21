defmodule Sequence.Application do
  use Application

  def start(_type, initial_number) do
    {:ok, _pid} = Sequence.Supervisor.start_link(initial_number)
  end
end
