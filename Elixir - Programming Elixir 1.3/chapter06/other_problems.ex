defmodule OtherProblems do

  # 4
  def sum(0), do: 0
  def sum(n) when n > 0, do: n + sum(n-1)
  def sum(n) when n < 0, do: IO.puts("Value needs to be positive my guy")


  # 5
  def gcd(0,y), do: y
  def gcd(x,0), do: x
  def gcd(x,y), do: gcd(y, rem(x,y))


  # 6
  # If actual is not an integer, complain
  def guess(actual, _range) when not is_integer(actual) do
    IO.puts("!! Expected an integer !!")
  end

  # If actual is an integer and range IS A RANGE
  def guess(actual, %Range{} = range) do

    # If actual is not within the range, complain
    if actual not in range do
      IO.puts("!! Actual number is not in given range !!")

    # Else - attempt the guesses
    else
      attempt = get_midpoint(range)
      do_guess(attempt, range, actual)
    end
  end

  # If range is not a range, complain
  def guess(_actual, _range) do
    IO.puts("!! Expected a range !!")
  end

  defp do_guess(attempt, range, actual) when attempt > actual do
    IO.puts("Guess of #{attempt} was greater than actual, trying again")
    new_range = Enum.min(range)..attempt-1
    new_attempt = get_midpoint(new_range)
    do_guess(new_attempt, new_range, actual)
  end

  defp do_guess(attempt, range, actual) when attempt < actual do
    IO.puts("Guess of #{attempt} was less than actual, trying again")
    new_range = attempt+1..Enum.max(range)
    new_attempt = get_midpoint(new_range)
    do_guess(new_attempt, new_range, actual)
  end

  defp do_guess(attempt, _range, actual) when attempt == actual do
    IO.puts("Guess was correct! Got #{actual}")
  end

  # Get midpoint of the range
  defp get_midpoint(range) do
    max_val = Enum.max(range)
    min_val = Enum.min(range)
    midpoint = div((max_val + min_val),2)
    midpoint
  end


  # 7.a)
  def float_to_string(input_float) do
    output_float = :erlang.float_to_binary(input_float, [decimals: 2])
    IO.puts("Input : #{input_float}")
    IO.puts("Formatted Output: #{output_float}")
  end

  # 7.b)
  # Run check if input is a string
  def get_environment_variable(variable) when is_binary(variable) do
    var = System.get_env(variable)
    display_variable(variable, var)
  end

  # If input is not a string, complain
  def get_environment_variable(_variable) do
    IO.puts("You gotta give me a string...")
  end

  # If the output is nil, likely not an environment variable, so complain
  defp display_variable(variable, nil) do
    IO.puts("I don't think \"#{variable}\" is a valid environment variable...")
  end

  # Else - display the results
  defp display_variable(variable, var) do
    IO.puts("#{variable} value is: #{var}")
  end

  # 7.c)
  def get_extension(filename) when is_binary(filename) do
    if String.contains?(filename, ".") do
      IO.puts("File Extension for \"#{filename}\" is #{Path.extname(filename)}")
    else
      IO.puts("I don't think \"#{filename}\" has an extension at the end...")
    end
  end

  # 7.d)
  def get_pwd() do
    {_, pwd} = File.cwd;
    IO.puts("Current working directory: #{pwd}")
  end

  # 7.f)
  def run_hello_world_in_shell do
    # echo Hello World -> syntax for printing hello world in windows cmd
    # System.cmd/2
    #  - Argument 1: command
    #  - Argument 2: arguments (MUST BE LIST)
    System.cmd("echo", ["Hello World"])
  end

end
