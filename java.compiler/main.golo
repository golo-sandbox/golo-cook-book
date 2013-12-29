module Interpreter

import compiler
import java.lang.String

function main = |args| {

  let humanClass = load("java", "org.k33g.Human")

  let john = humanClass: newInstance()
  println(john: toString())

  let bob = humanClass: getConstructor(String.class, String.class): newInstance("Bob", "Morane")
  println(bob: firstName() + " " + bob: lastName())
  println(bob: toString())

  #let conf = map[
  #  ["extends", "org.k33g.Human"],
  #  ["overrides", map[
  #    ["toString", |super, this| {
  #      return super(this)
  #    }]
  #  ]]
  #]
  #let h = AdapterFabric(): maker(conf): newInstance()


}

