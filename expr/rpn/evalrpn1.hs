import EvalRPN

main :: IO ()
main = do
  let x = evalRPN "2 3 + 4 1 + *"
  let y = evalRPN "2"
  let z = evalRPN ""
  print x
  print y
  print z
