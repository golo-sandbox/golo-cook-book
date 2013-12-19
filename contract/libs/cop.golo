module cop

local function stack = {
  foreach item in java.lang.Thread.currentThread(): getStackTrace() {
    println(item: getLineNumber() + " " + item: getClassName() + " " + item: getMethodName())            
  } 
}

function contract = |description, from| ->
  DynamicObject()
    : define("requires", |this, predicate| {
        if predicate is false { 
          raise("["+from+"] contract : \""+description+"\" is not respected!") 
        }
      })

