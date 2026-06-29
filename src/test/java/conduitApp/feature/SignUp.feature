Feature: Testing the SignUp Feature

Background: Setting up the base url
   Given url baseURL
Scenario: A new user having unique set of values is able to sign-up
   * def randomData = read("classpath:helpers/generateRandomData.js");
   * def reqPayload = {"email":#(randomData().randomEmail()),"password":"Karate19923","username":#(randomData().randomUserName())}
   Given path "users"
   Given request
   """
   {"user":{"email":#(reqPayload.email),"password":#(reqPayload.password),"username":#(reqPayload.username)}}
   """
   When method Post
   Then status 201

   