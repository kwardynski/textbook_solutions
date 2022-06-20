defmodule Parallel do

  def pmap(collection, fun) do
    me = self

    collection

      # First transformation: maps collection into a list of PIDs, where each PID
      # runs the given function on an individual list element.
      |> Enum.map(fn(elem) ->
          spawn_link fn -> (send me, {self, fun.(elem)}) end
        end)

      # Second transformation: converts the list of PIDs into the results returned
      # by the process corresponding to the PID in the list. ^pid in the receive
      # block ensures we get the answers back in the correct order, without it we'd receive
      # them in a rando order.
      |> Enum.map(fn(pid) ->
          receive do {_pid, result} -> result end
        end)
  end

end
