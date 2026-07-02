# Here after verifying status code, we are verifying that the favCount has increased by 1
# We are verifying that we have indeed made the fav count increment to the original slugID
Feature: Increase like count for an article

   Background: Preconditions
      Given url baseURL

   Scenario: User likes the article
      Given path "articles", slugID, "favorite"
      Given header Authorization = authToken
      Given request
         """
         {}
         """
      When method Post
      Then status 200
      And match response.article.slug == slugID
      * def newFavCount = response.article.favoritesCount
      And match response.article.favoritesCount == oldFavCount + 1