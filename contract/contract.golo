module contract

#import cop
import tools

function salut = |message| {
  require(
      message isnt null and message oftype java.lang.String.class
    , "message must be a string and not null"
  )
  
  println("SALUT " + message) 
}

function main = |args| {

  #salut(null)
  hello("bob")
  hello(12)     # --> exception / stops the program
  #hello(null)   # --> exception
}

