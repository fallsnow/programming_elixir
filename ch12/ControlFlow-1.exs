defmodule FizzBuzz do
  def upto(n), do: _fizzbuzz_word(1, n, rem(1,3) == 0, rem(1,5) == 0)

  defp _fizzbuzz_word(current, n, _, _)
  when current > n, do: nil

  defp _fizzbuzz_word(current, n, rem3, rem5) do
    case {rem3, rem5} do
      {true, false} -> IO.puts "Fizz"
      {false, true} -> IO.puts "Buzz"
      {true, true}  -> IO.puts "FizzBuzz"
      {false, false} -> IO.puts current
    end
    _fizzbuzz_word(current+1, n, rem(current+1,3) == 0, rem(current+1,5) == 0)
  end

# A Possible Solution
#
# def upto(n) when n > 0 do
#   1..n |> Enum.map(&(fizzbuzz(&1))
# end
#
# defp fizzbuzz(n) do
#   case { rem(n,3), rem(n,5), n } do
#     { 0, 0, _ } -> "FizzBuzz'
#     { 0, _, _ } -> "Fizz"
#     { _, 0, _ } -> "Buzz"
#     { _, _, n } -> n
#   end
# end

end

FizzBuzz.upto(20)
