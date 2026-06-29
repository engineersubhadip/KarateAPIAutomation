Running via the CLI

How to run all the tests in a particular feature file ?

mvn clean test "-Dkarate.options=classpath:conduitApp/feature/FeatureFileName.feature"

How to run a particular scenario from all the feature files ?

[Assume this scenario has a tag @Debug]

mvn clean test "-Dkarate.options=--tags @Debug"

How to ignore certain scenario ?

Put @ignore

I want to execute all the tags except those marked with @skipme ?

mvn clean test "-Dkarate.options=--tags ~@skipme"
