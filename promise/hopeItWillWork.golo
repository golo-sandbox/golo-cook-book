module hopeitwillwork

import hopes

function main = |args| {

  let execuTor = getExecutor()

  # promise
  let first = Hope(execuTor)
    : it(|arg| {
        println(arg)
        java.lang.Thread.sleep(5000_L)
        return 5 * arg
    })
    : success(|value| { # if success
        println("success : " + value)
    })
    : error(|error| { # on error
        println("error : " + error)
    })
    : always(|value| { # but always
        println("always : " + value)
    })
    : willWork(2) 

  # promise with error
  let other = Hope(execuTor)
    : it(|arg| {
        println(arg)
        java.lang.Thread.sleep(1000_L)
        return 5 * arg # arg is null
    })
    : success(|value| { # if success
        println("success : " + value)
    })
    : error(|error| { # on error
        println("error : " + error)
    })
    : always(|value| { # but always
        println("always : " + value)
    })
    : willWork() # arg is null : task throws java.lang.NullPointerException

  println("first result : %s , other result %s "
    : format(
          first: result()?:toString()
        , other: result()?: toString()
    ))

  java.lang.Thread.sleep(5000_L)

  println("first result : %s , other result %s "
    : format(
          first: result()?:toString()
        , other: result()?: toString()
    ))

}