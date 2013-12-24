module private.members


function Human = |name| {

  # _name_ is private
  # _name_ is a DynamicObject, because we need to change his value inside closure 
  # or you can use a structure
  let _name_ = DynamicObject(): value(name)
  # _hello_ is private
  let _hello_ = |msg| -> println(msg)

  return DynamicObject()
    : define("getName", |this| -> _name_: value())
    : define("setName", |this, value| -> _name_: value(value))
    : define("hello", |this, message| -> _hello_(message))
}

function main = |args| {

  let bob = Human("Bob Morane")
  println(bob: getName())

  bob: hello("i'm bob")

  bob: setName("BOB MORANE")
  println(bob: getName())

}