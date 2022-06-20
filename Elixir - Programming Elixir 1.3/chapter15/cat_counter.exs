defmodule Scheduler do

  # This module is lifted straight from the previous fib example, just slightly
  # modified to call the CatCounter module
  # We'll set the running processes to 5 for simplicity

  def run(num_processes, module, func, files) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self]) end)
    |> schedule_processes(files, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [next | tail] = queue
        send pid, {:fib, next, self}
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      {:answer, number, result, pid} ->
        schedule_processes(processes, queue, [{number, result} | results])
    end
  end

end


defmodule CatCounter do

  def cat(scheduler) do
    send scheduler, {:ready, self()}
    receive do
      {:cat, file, client} -> send client, {:answer, file, cat_counter(file), self()}
                              cat(scheduler)
      {:shutdown}          -> exit(:normal)
    end
  end

  def cat_counter(file) do
    fid = File.open!(file)
    Enum.map(IO.stream(fid, :line), fn(x) -> String.trim(x) end)
    |> count_cat()
  end

  def count_cat(word_list) do
    count_map = Enum.frequencies(word_list)
    case count_map["cat"] do
      nil -> 0
      _   -> count_map["cat"]
    end
  end

end
