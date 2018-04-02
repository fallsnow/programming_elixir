defmodule Parse do

  def calculate(str) do
    index = Enum.find_index(str, fn(x) -> x in '+-*/' end)
    operator = Enum.at(str, index)
    operand1 = List.delete(Enum.slice(str, 0..index-1), ?\s)
    operand2 = List.delete(Enum.slice(str, index+1..length(str)), ?\s)
    _calculate(operator, operand1, operand2)
  end

  defp _calculate(operator, operand1, operand2) do
    op1 = number(operand1)
    op2 = number(operand2)
    case operator do
      ?+ -> op1 + op2
      ?- -> op1 - op2
      ?* -> op1 * op2
      ?/ -> op1 / op2
      _  -> raise "Invalid equation #{op1} #{operator} #{op2}"
    end
  end

  def number([ ?- | tail ]), do: _number_digits(tail, 0) * -1
  def number([ ?+ | tail ]), do: _number_digits(tail, 0)
  def number(str),           do: _number_digits(str, 0)

  defp _number_digits([], value), do: value
  defp _number_digits([ digit | tail ], value)
  when digit in '0123456789' do
    _number_digits(tail, value*10 + digit - ?0)
  end
  defp _number_digits([ non_digit | _ ], _) do
    raise "Invalid digit '#{[non_digit]}'"
  end
end

# List.foldl(opearand, 0, fn(x, acc) -> acc*10 + (x - ?0) end)
# List.delete(operand, ?\s)
