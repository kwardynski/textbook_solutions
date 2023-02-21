defmodule TokenReturn do

  def spawn_token_return do
    spawn(__MODULE__, :return_token, [])
  end

  def return_token do
    receive do
      {_, token} -> IO.puts(token)
    end
  end


end

# Define "tokens"
fred = TokenReturn.spawn_token_return()
betty = TokenReturn.spawn_token_return()

# Send "tokens"
send fred, {self, "fred"}
send betty, {self, "betty"}
