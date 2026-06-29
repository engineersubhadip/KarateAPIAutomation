Feature: Tests for the home page

Scenario: Check status code 200 for tags end-point
   Given url "https://conduit-api.bondaracademy.com/api/tags"
   When method Get
   Then status 200

Scenario: Get 10 articles from the page
   Given url "https://conduit-api.bondaracademy.com/api/articles?limit=10&offset=0"
   When method Get
   Then status 200

Scenario: Get 10 articles from the page [Optimized manner 1]
   Given url "https://conduit-api.bondaracademy.com/api/articles"
   Given param limit = 10
   Given param offset = 0
   When method Get
   Then status 200

Scenario: Get 10 articles from the page [Optimized manner 2]
   Given url "https://conduit-api.bondaracademy.com/api/articles"
   Given params {limit : 10, offset : 0}
   When method Get
   Then status 200   