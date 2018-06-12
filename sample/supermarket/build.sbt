enablePlugins(ScalaJSPlugin)

name := "Supermarket"
scalaVersion := "2.12.4"
// This is an application with a main method
scalaJSUseMainModuleInitializer := true
libraryDependencies += "org.scala-js" %%% "scalajs-dom" % "0.9.5"
libraryDependencies += "com.lihaoyi" %%% "scalatags" % "0.6.2"
