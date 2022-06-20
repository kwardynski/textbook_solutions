defmodule Ticker do

  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [%{}, 1])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients, call) do

    # Put a new client PID in the clients map, follows the format
    # %{client_num: int => client_pid: PID}, with client_num incrementing
    # with each new client registered
    receive do
      {:register, pid} ->
        IO.puts("Registering #{inspect pid}")
        Map.put(clients, Enum.count(clients)+1, pid)
        |> generator(call)
      after
        @interval ->
          IO.puts("tick sent to #{inspect clients[call]}")
          next_call = send_tick(clients, call)
        generator(clients, next_call)
    end
  end


  # Sends a tick to the client specified by call, then returns the
  # number of the "next" client in linee
  def send_tick(clients, call) do
    case Enum.count(clients) do
      0 -> call
      _   ->
        send clients[call], {:tick}
        get_next_call(Enum.count(clients), call)
    end
  end

  # Returns the value used to determine the next client in line
  # to receive a tock message. If call number is the last in the
  # client map, returns 1, else returns call + 1
  def get_next_call(map_length, call) do
    cond do
      map_length == 0    -> call
      map_length == call -> 1
      true               -> call + 1
    end
  end

end


defmodule Client do

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts("tock in client")
        receiver
    end
  end

end
