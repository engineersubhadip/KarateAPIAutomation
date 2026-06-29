Feature: Articles

Background: Setting up Base url
   Given url "https://conduit-api.bondaracademy.com/api/"

Scenario: Capture user token
   Given path "users/login"
   Given request 
   """
   {
    "user": {
        "email": "karate011@test.com",
        "password": "Karate011"
       }
   }
   """
   When method Post
   Then status 200
   * def userToken = "Token "+response.user.token
   * print userToken

   Given path "articles/"
   Given header Authorization = userToken
   Given request
   """
   {
    "article": {
        "title": "header011234",
        "description": "header2",
        "body": "header3",
        "tagList": []
      }
   }
   """
   When method Post
   Then status 201
   And match response.article.title == "header011234"
   And match response.article.description == "header2"