module compiler

import javax.tools.JavaCompiler
import javax.tools.ToolProvider

import java.io.File
import java.net.URLClassLoader

----
#parameter

- javaSourceFile : String sourceFile

##sample

    compile("java/org/k33g/HelloWorld.java")

----
function compile = |javaSourceFile| {
  require(javaSourceFile oftype java.lang.String.class, "parameter of compile must be a String")
  require(File(javaSourceFile): exists() is true, "This file : %s doesn't exist": format(javaSourceFile))

  let compileClass = |sourceFile| {
    let compiler = ToolProvider.getSystemJavaCompiler()   #JavaCompilerTool
    let results = compiler: run(null, null, null, sourceFile)
  }

  let javaFile = File(javaSourceFile)
  let classFileName = javaFile: getName(): split(".java"): get(0) + ".class"
  let directory = javaFile: getAbsolutePath(): split(javaFile: getName()): get(0)
  let classFile = File(directory + classFileName)

  # java source file is compiled only if .class doesn't exist or
  # if java source file has been modified
  if classFile: exists() is false or (javaFile: lastModified() > classFile: lastModified())is true {
    compileClass(javaSourceFile)
  }

}

----
#parameters

- javaClassDirectory : String : relative directory
- className : String : package + class name

##sample

    let klass = load("java", "org.k33g.HelloWorld")

----
function load = |javaClassDirectory, className| {
  require(javaClassDirectory oftype java.lang.String.class, "1st parameter of load must be a String")
  require(className oftype java.lang.String.class, "2nd parameter of load must be a String")
  require(File(javaClassDirectory): exists() is true, "This directory : %s doesn't exist": format(javaClassDirectory))

  #compilation if necessary ...
  compile(javaClassDirectory + "/" + className: replace(".","/") + ".java")

  let file = File(javaClassDirectory)

  #let url = file: toURI(): toURL()
  let url = file: toURL()
  let urls = java.lang.reflect.Array.newInstance(java.net.URL.class, 1)
  java.lang.reflect.Array.set(urls, 0, url)
  let cl = URLClassLoader(urls)

  let cls = cl: loadClass(className)
  return cls
}