Feature: Articles

Background: Capturing the user token during login process
   Given url "https://conduit-api.bondaracademy.com/api/"
   * def authToken = callonce read('classpath:helpers/CreateToken.feature') {"email" : "karate011@test.com", "password" : "Karate011"}
   * def token = authToken.userToken

@ignore
Scenario: Creating article
   Given path "articles/"
   Given header Authorization = userToken
   Given request
   """
   {
    "article": {
        "title": "Header1",
        "description": "header2",
        "body": "header3",
        "tagList": []
      }
   }
   """
   When method Post
   Then status 201
   And match response.article.title == "Header1"
   And match response.article.description == "header2"

# @ignore
Scenario: Deleting the an article
   # User will first create the article and then delete the same article and verify it has been deleted
   Given path "articles/"
   Given header Authorization = token
   Given request
   """
   {"article":{"title":"Header2","description":"About section","body":"Optional","tagList":[]}}
   """
   When method Post
   Then status 201
   * def slugVal = response.article.slug

   # * Lets verify the article created is showing in the UI
   Given path "articles"
   Given params {limit : 10, offset : 0}
   Given header Authorization = token
   When method Get
   Then status 200
   * def currentListOfArticles = response.articles.map((ele) => ele.title)
   And match currentListOfArticles contains  "Header2"

   # Now we are about to delete the same article
   Given path `articles/${slugVal}`
   Given header Authorization = token
   When method Delete
   Then status 204

   # * Now the deleted article should not be present in the current list of articles shown in the UI
   Given path "articles"
   Given params {limit : 10, offset : 0}
   Given header Authorization = token
   When method Get
   Then status 200
   * def updatedListOfArticles = response.articles.map((ele) => ele.title)
   And match updatedListOfArticles !contains "Header2"
