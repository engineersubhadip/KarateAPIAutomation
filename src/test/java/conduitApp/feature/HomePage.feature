Feature: Tests for the home page

Background: Define URL
   Given url "https://conduit-api.bondaracademy.com/api/"

Scenario: Check status code 200 for tags end-point
   Given path "tags"
   When method Get
   Then status 200

Scenario: Check response tags is an array
   Given path "tags"
   When method Get
   Then status 200
   And match response.tags == '#array'

Scenario: Check response tags contains "YouTube"
   Given path "tags"
   When method Get
   Then status 200
   And match response.tags deep contains "YouTube"

Scenario: Verify multiple values from response
   Given path "tags"
   When method Get
   Then status 200
   And match response.tags deep contains ["YouTube", "Blog"]

Scenario: Verify certain values are not present
   Given path "tags"
   When method Get
   Then status 200
   And match response.tags deep !contains ["Haiti", "Wilson"]   

Scenario: Get 10 articles from the page [Optimized manner 2]
   Given path "articles"
   Given params {limit : 10, offset : 0}
   When method Get
   Then status 200   