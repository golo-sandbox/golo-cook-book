module contract

function contract = |description, from| ->
  DynamicObject()
    : define("requires", |this, predicate| {
        if predicate is false { raise("["+from+"] contract : \""+description+"\" is not respected!") }
      })

function hello = |message| {
  contract("message must be a string and not null", "hello")
    : requires(message isnt null and message oftype java.lang.String.class)
    
  println("HELLO " + message)
}

function main = |args| {
  hello("bob")
  hello(12)     # --> exception / stops the program
  hello(null)   # --> exception
}

