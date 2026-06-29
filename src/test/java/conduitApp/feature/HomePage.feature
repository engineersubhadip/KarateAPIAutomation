Feature: Tests for the home page

Scenario: Check status code 200 for tags end-point
   Given url "https://conduit-api.bondaracademy.com/api/tags"
   When method Get
   Then status 200

Scenario: Get 10 articles from the page
   Given url "https://conduit-api.bondaracademy.com/api/articles?limit=10&offset=0"
   When method Get
   Then status 200