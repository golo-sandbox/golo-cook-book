module funwithjs

import javax.script.ScriptEngineManager

function main = |args| {
  # create a script engine manage
  let factory = ScriptEngineManager()
  # create a JavaScript engine
  let engine = factory: getEngineByName("JavaScript")
  # evaluate JavaScript code from String
  engine: eval(
  """
    var a = 45
    print("result is", a * 5)
  """
  )

  # expose String object as variable to script
  engine: put("iam","@k33g.org")
  engine: eval(
  """
    print("Hello", iam)
  """
  )

  # evaluate functions
  engine: eval(
  """
    function add(a,b) {
      return a + b;
    }
    function multiply(a,b) {
      return a * b;
    }
  """
  )
  
  # invoke the global functions named "add" then "multiply"
  println(engine: invokeFunction("add", 10, 25))
  println(engine: invokeFunction("multiply", 10, 25))
}


