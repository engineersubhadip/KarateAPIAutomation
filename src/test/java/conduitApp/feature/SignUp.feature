Feature: Testing the SignUp Feature

Background: Setting up the base url
   Given url baseURL
Scenario: A new user having unique set of values is able to sign-up
   * def randomData = read("classpath:helpers/generateRandomData.js");
   * def randomEmail = randomData().generateRandomEmail();
   * def randomUserName = randomData().generateRandomUserName();

   Given path "users"
   Given request
   """
   {"user":{"email":#(randomEmail),"password":"telemachus","username":#(randomUserName)}}
   """
   When method Post
   Then status 201
   And match response ==
   """
   {
      "user": {
         "id": "#number",
         "email": #(randomEmail),
         "username": #(randomUserName),
         "bio": null,
         "image": "#ignore",
         "token": "#string"
      }
   }
   """

   