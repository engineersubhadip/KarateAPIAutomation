Feature: Create user token

Scenario: Create user token for login purpose
   Given url "https://conduit-api.bondaracademy.com/api/"
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