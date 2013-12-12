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

function Observer = -> DynamicObject(): define("update", |this| -> raise("update not implemented"))

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
  
  let september = DynamicObject()
    : define("update", |this| {
        println(
          "September : %s %s has changed, counter is %s": format(
              this: subject(): firstName()
            , this: subject(): lastName()
            , this: subject(): counter()
          )
        )
      })

  let windmark = DynamicObject()
    : define("update", |this| {
        println(
          "Windmark : %s %s has changed, counter is %s": format(
              this: subject(): firstName()
            , this: subject(): lastName()
            , this: subject(): counter()
          )
        )
    })

  peter: attach(september): attach(windmark): start(5)

}