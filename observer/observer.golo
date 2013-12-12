module observer

function Observable = {
  let observers = list[]

  let isUpdatable = |object| {
    let properties = object: properties(): filter(|property|-> property: getKey(): equals("update"))
    if properties: size(): equals(1) {
      return isClosure(properties :iterator(): next(): getValue())
    } else {
      return false
    }
  }     

  let _observable_ = DynamicObject()
    : define("attach", |this, observer| {    
        if isUpdatable(observer) {
          observer: subject(this)
          observers: add(observer)
        } else {
          raise("oops i did it again")
        }
        return this
      })
    : define("detach", |this, observer| {
        observers: remove(observer)
        return this
      })
    : define("notify", |this| {
        observers: each(|observer| -> observer: update())
        return this
      })
  return _observable_
}

function Observer = {

  let isImplemented = |method, object| {
    let properties = object: properties(): filter(|property|-> property: getKey(): equals(method))
    if properties: size(): equals(1) {
      return isClosure(properties :iterator(): next(): getValue())
    } else {
      return false
    }    
  }

  let isObservable = |object| {
    return isImplemented("attach", object) and isImplemented("notify", object) 
  }  

  let _observer_ = DynamicObject()
  : define("update", |this| -> raise("update not implemented"))
  : define("observe", |this, subject| {
      if isObservable(subject) {
        subject: attach(this)
      } else {
        raise("oops i did it again")
      }
    })
  :define("forget", |this, subject| {
      if isObservable(subject) {
        subject: detach(this)
      } else {
        raise("oops i did it again")
      }    
    })
  return _observer_
} 



function main = |args| {

  let peter = DynamicObject(): mixin(Observable())
    : firstName("Peter")
    : lastName("Bishop")
    : counter(null)
    : define("start", |this, howMany| {
        howMany: times(|i|{
          this: counter(i)
          this: notify()
        })
        return this
      })
  
  let september = DynamicObject(): mixin(Observer())
    : define("update", |this| {
        println(
          "September : %s %s has changed, counter is %s": format(
              this: subject(): firstName()
            , this: subject(): lastName()
            , this: subject(): counter()
          )
        )
      })

  let august = DynamicObject(): mixin(Observer())
    : define("update", |this| {
        println(
          "August : %s %s has changed, counter is %s": format(
              this: subject(): firstName()
            , this: subject(): lastName()
            , this: subject(): counter()
          )
        )
      })

  let windmark = DynamicObject(): mixin(Observer())
    : define("update", |this| {
        println(
          "Windmark : %s %s has changed, counter is %s": format(
              this: subject(): firstName()
            , this: subject(): lastName()
            , this: subject(): counter()
          )
        )
    })


  august: observe(peter)

  peter: attach(september): attach(windmark): start(5)

  august: forget(peter)

  peter: start(2)

}