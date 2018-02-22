defmodule Chop do
  def guess(actual, range) do
    first..last = range
    IO.puts "It is #{div(first + last, 2)}?"
    search(actual, range, div(first + last, 2))
  end

  def search(actual, range, guess) when actual == guess do
    IO.puts actual
  end

  def search(actual, range, guess) when actual < guess do
    first..last = range
    IO.puts "It is #{div(first + guess, 2)}?"
    search(actual, first..guess, div(first + guess, 2))
  end

  def search(actual, range, guess) when actual > guess do
    first..last = range
    IO.puts "It is #{div(guess + last, 2)}?"
    search(actual, guess..last, div(guess + last, 2))
  end
end

Chop.guess(273, 1..1000)
