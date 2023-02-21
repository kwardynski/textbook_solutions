# A simple example to demonstrate stateful persistent server behavior
# This can be abstracted by the GenServer behavior introduced in Chapter 6

defmodule Calculator do

  def start do
    spawn(fn -> loop(0) end)
  end

  # Main message handling loop
  def loop(current_value) do

    new_value = receive do

      # Request to query the calculator's current value
      {:value, caller} ->
        send(caller, {:response, current_value})  # send the current value back to the caller
        current_value                             # return current_value

      # Arithmetic requests
      {:add, value} -> current_value + value
      {:sub, value} -> current_value - value
      {:mul, value} -> current_value * value
      {:div, value} -> current_value / value

      # Capture anything else as invalid
      invalid_request ->
        IO.puts("Invalid request recieved: #{inspect invalid_request}")
        current_value
    end

    loop(new_value)
  end


  # External "API"
  def value(server_pid) do
    send(server_pid, {:value, self()})
    receive do
      {:response, value} -> value
    end
  end

  def add(server_pid, value), do: send(server_pid, {:add, value})
  def sub(server_pid, value), do: send(server_pid, {:sub, value})
  def mul(server_pid, value), do: send(server_pid, {:mul, value})
  def div(server_pid, value), do: send(server_pid, {:div, value})


end
