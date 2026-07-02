Feature: Dummy Feature

   Scenario: Creating random test data
      * def randomData = read("classpath:helpers/generateRandomData.js")
      * def randomEmail = randomData().generateRandomEmail()