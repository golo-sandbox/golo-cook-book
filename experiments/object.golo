module obj

augment java.lang.Object {
  function hello = |this| {
    println("helllooooooo")
  }
}


function main = |args| {


  let conf = map[
    ["extends", "java.lang.Object"],
    ["overrides", map[
      ["*", |super, name, args| {
        println("--> " +name)
      }]
      ]
    ]

  ]
  let o = AdapterFabric(): maker(conf): newInstance()

  o: hello()

}