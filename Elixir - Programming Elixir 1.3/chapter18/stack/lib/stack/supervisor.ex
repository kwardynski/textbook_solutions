defmodule Stack.Supervisor do
  use Supervisor

  def start_link(initial_list) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [initial_list])
    start_workers(sup, initial_list)
    result
  end

  def start_workers(sup, initial_list) do
    # Start the "stash" worker
    {:ok, stash} = Supervisor.start_child(
      sup, worker(Stack.Stash, [initial_list])
      )

    # Start the SubSupervisor for the actual Stack server
    Supervisor.start_child(
      sup, supervisor(Stack.SubSupervisor, [stash])
    )
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end

end
