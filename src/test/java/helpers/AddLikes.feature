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
      And match response.article.favoritesCount == oldFavCount + 1