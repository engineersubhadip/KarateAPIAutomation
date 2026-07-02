Feature: User will like the first article if it has favourite count more than 3

   Background: Preconditions
      Given url baseURL
      * def token = callonce read("classpath:helpers/CreateToken.feature")
      * def authToken = token.userToken


   Scenario: Conditional Logic in karate
      Given path "articles"
      Given params {limit : 10, offset : 0}
      Given header Authorization = authToken
      When method Get
      Then status 200
      * def firstArticleSlugID = response.articles[0].slug
      * def currentFavCount = response.articles[0].favoritesCount
      * if (currentFavCount > 3) karate.call("classpath:helpers/AddLikes.feature", {"authToken": authToken, "slugID": firstArticleSlugID, "oldFavCount": currentFavCount})