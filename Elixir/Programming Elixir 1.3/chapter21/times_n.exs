defmodule Times do

  defmacro times_n(n) do

    # Use string interpolation to dynamically construct the function handle
    # Use String.to_atom because unquoting the string results in a compile error downstream
    fun = String.to_atom("times_#{n}")

    # Write out the function definition (behavior specified by the question)
    quote do
      def unquote(fun)(x) do
        x*unquote(n)
      end
    end

  end

end

defmodule Test do
  require Times
  Times.times_n(3)
  Times.times_n(4)
end

IO.puts(Test.times_3(4))  # => 12
IO.puts(Test.times_4(5))  # => 12
