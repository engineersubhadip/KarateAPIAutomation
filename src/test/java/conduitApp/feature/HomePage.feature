Feature: Tests for the home page

Background: Define URL
   Given url baseURL

Scenario: Check status code 200 for tags end-point
   Given path "tags"
   When method Get
   Then status 200

Scenario: Check response tags is an array
   Given path "tags"
   When method Get
   Then status 200
   And match response.tags == '#array'

Scenario: Validate each value of the json Array "tags" is a String
   Given path "tags"
   When method Get
   Then status 200
   And match each response.tags == "#string"

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

Scenario: Contains any assertion
   Given path "tags"
   When method Get
   Then status 200
   And match response.tags contains any ["YouTube", "Not exist Value"]

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

Scenario: Verify size of the json Array is 10
   Given path "articles"
   Given params {limit : 10, offset : 0}
   When method Get
   Then status 200      
   And match response.articles == "#[10]"
   And match response.articlesCount == 10

Scenario: Verify the article count does not equal to 20
   Given path "articles"
   Given params {limit : 10, offset : 0}
   Given method Get
   Then status 200
   And match response.articlesCount != 20

Scenario: Verify the schema of the response generated from articles
   Given path "articles"
   Given params {limit : 10, offset: 0}   
   When method Get
   Then status 200
   And match response == {"articles" : "#array", "articlesCount" : "#number"}

Scenario: Verify that each article object was created in the current year 2026
   Given path "articles"
   Given params {limit : 10, offset : 0}
   When method Get
   Then status 200
   * def createdDate = response.articles.map((ele) => ele.createdAt)
   And match each createdDate == "#string"
   And match each createdDate contains "2024"

Scenario: Verify that each article object should have favourite count more than 1
   Given path "articles"
   Given params {limit : 10, offset : 0}
   When method Get
   Then status 200
   * def currentFavCount = response.articles.map((ele) => ele.favoritesCount)
   And match each currentFavCount == '#? _ > 1'

Scenario: Verify at least one of the bio is null
   Given path "articles"
   Given params {limit : 10, offset : 0}
   When method Get
   Then status 200
   * def currListOfBio = response.articles.map((ele) => ele.author.bio)
   * match currListOfBio contains null

Scenario: Verify at least one of the bio is null [Path Shortner]
   Given path "articles"
   Given params {limit : 10, offset : 0}
   When method Get
   Then status 200
   And match response.articles[*]..bio contains null

Scenario: Verify the following element is a boolean
   Given path "articles"
   Given params {limit : 10, offset : 0}
   When method Get
   Then status 200
   And match each response.articles[*]..following == "#boolean"

Scenario: Verify the favouriteCount element should be a number
   Given path "articles"
   Given params {limit : 10, offset : 0}
   When method Get
   Then status 200
   And match each response.articles[*]..favoritesCount == "#number"

Scenario: Verify the bio section element can be string or null
   Given path "articles"
   Given params {limit : 10, offset : 0}
   When method Get
   Then status 200
   And match each response.articles[*]..bio == "##string"

Scenario: Verify each article object schema
   Given path "articles"
   Given params {limit : 10, offset : 0}
   When method Get
   Then status 200
   And match each response.articles == 
   """
      {
         "slug": "#string",
         "title": "#string",
         "description": "#string",
         "keyNotPresent" : "##string",
         "body": "#string",
         "tagList": "#[] #string",
         "createdAt": "#ignore",
         "updatedAt": "#ignore",
         "favorited": "#boolean",
         "favoritesCount": "#number",
         "author": {
               "username": "#string",
               "bio": "##string",
               "image": "#string",
               "following": "#boolean"
         }
      }
    """
    And match response.articles == "#[10]"