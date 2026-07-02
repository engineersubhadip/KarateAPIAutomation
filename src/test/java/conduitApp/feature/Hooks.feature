Feature: Hooks

   # afterHook

   Background: Invoking the Dummy feature file
      # If we would have used callonce it would have been a Before Hook
      * print "This is the Before Each Hook"

      * configure afterScenario =
         """
         function () {
         karate.log("This is the after scenario")
         }
         """

   Scenario: Scenario 1
      * print "Random Email from scenario 1 -> "

   Scenario: Scenario 2
      * print "Random Email from scenario 2 -> "