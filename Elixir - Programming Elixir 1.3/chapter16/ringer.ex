defmodule Ringer do

  @interval 2000
  @name :ringer

  def start do
    pid = spawn(__MODULE__, :generator, [%{}, 0])
    :global.register_name(@name, pid)
  end



end



defmodule Client do


end
