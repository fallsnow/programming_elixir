fizz_buzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, a -> a
end

fizz_buzz.(0,0,0)
fizz_buzz.(0,1,1)
fizz_buzz.(1,0,1)
fizz_buzz.(1,1,2)

