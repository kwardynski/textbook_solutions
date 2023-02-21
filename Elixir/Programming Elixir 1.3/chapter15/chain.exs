defmodule Chain do

  # This is the function run by the separate processes. When it receives
  # a number, it imcrements it and sents it on to the next process
  def counter(next_pid) do
    receive do
      n ->
        send next_pid, n+1
    end
  end


  # This function receives the number of processes to create. Each process created
  # has to receive the PID of the process before it, so it knows where to pass the
  # updated number.
  def create_processes(n) do

    # Reduce call iterates over the range [1,n], and each time passes an accumulator
    # as the secand parameter to its function. The initial alue of teh accumulator is
    # our PID (self).
    # Spawn spins up a new process that runs the counter function, using the third
    # parameter of spawn to pass in the acc's current value (initially self). The value
    # spawn returns is the PID of the newly created process, which becomes the acc
    # value for the next iteration
    last = Enum.reduce 1..n, self,
            fn (_, send_to) ->
              spawn(Chain, :counter, [send_to])
            end

    # Start the count by sending a zero to the last process
    send last, 0

    # Wait for the result to come back to us
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end

end
