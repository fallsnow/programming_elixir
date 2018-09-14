defprotocol Cypher do
  @fallback_to_any true
  def encrypt(string, shift)
end

defimpl Cypher, for: [List, BitString] do
  def encrypt(string, shift) do
    Enum.each string, fn char -> IO.puts "#{inspect (char + shift)}" end
  end
end

Cypher.encrypt('hoge', 1)
Cypher.encrypt([1, 2, 3], 1)



#defimpl Collection, for: [List, Tuple, BitString, Map] do
#  def is_collection?(_), do: true
#end

#defimpl Collection, for: Any do
#  def is_collection?(_), do: false
#end

#Enum.each [ 1, 1.0, [1,2], {1,2}, %{}, "cat" ], fn value ->
#  IO.puts "#{inspect value}: #{Collection.is_collection?(value)}"
#end
