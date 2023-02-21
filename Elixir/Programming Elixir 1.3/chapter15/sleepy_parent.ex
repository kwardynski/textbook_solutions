defmodule SleepyParent do

  # Sleepy Parent "driver" function
  def sleepy_parent(child_type, conn_type) do

    # Valiate inputs
    child_type = validate_inputs(child_type, ["active_child", "active_child_exception"])
    conn_type = validate_inputs(conn_type, ["link", "monitor"])

    # Call appropriate helpers
    case conn_type do
      "link"    -> spawn_link(SleepyParent, String.to_atom(child_type), [self()])
      "monitor" -> spawn_monitor(SleepyParent, String.to_atom(child_type), [self()])
    end

    # Hold for 0.5s and receive message
    Process.sleep(500)
    receive_message()
  end

  # Send a message
  def active_child(parent) do
    send parent, "AAAAAH!"
  end

  # Throw error instead
  def active_child_exception(parent) do
    raise RuntimeError, message: "I'm throwing an error here"
  end

  # Print a message if received
  def receive_message() do
    receive do
      message -> IO.puts("#{message}")
    end
  end

  # Validate inputs
  def validate_inputs(input, valid_inputs) do
    cond do
      Enum.member?(valid_inputs, input) -> input
      true                              -> raise RuntimeError, message: "Invalid input received"
    end
  end

end
