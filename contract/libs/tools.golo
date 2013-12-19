module tools

import cop

function hello = |message| {
  require(
      message isnt null and message oftype java.lang.String.class
    , "message must be a string and not null"
  )
  println("HELLO " + message)
}