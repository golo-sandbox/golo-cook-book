module private.members


function Human = |name| {

  # _name_ is private
  # _name_ is a DynamicObject, because we need to change his value inside closure 
  # or you can use a structure
  let _name_ = DynamicObject(): value(name)

  return DynamicObject()
    : define("getName", |this| -> _name_: value())
    : define("setName", |this, value| -> _name_: value(value))
}

function main = |args| {

  let bob = Human("Bob Morane")
  println(bob: getName())

  bob: setName("BOB MORANE")
  println(bob: getName())

}