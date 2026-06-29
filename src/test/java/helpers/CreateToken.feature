Feature: Create user token

Scenario: Create user token for login purpose
   Given url baseURL
   Given path "users/login"
   Given request 

   """
   {
    "user": {
        "email": #(userEmail),
        "password": #(userPassword)
       }
   }
   """
   When method Post
   Then status 200
   * def userToken = "Token "+response.user.token