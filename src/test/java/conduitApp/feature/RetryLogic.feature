Feature: Implement retry logic

   Background: Preconditions
      Given url baseURL
      * def token = karate.callSingle("classpath:helpers/CreateToken.feature")
      * def authToken = token.userToken


   Scenario: User retries until the Get call has response == 8 articles
      * configure retry = {count : 10, interval : 100}
      Given path "articles"
      Given params {limit : 10, offset : 0}
      Given header Authorization = authToken
      And retry until response.articles.length == 8
      When method Get
      Then status 200

   @Debug
   Scenario: User retries until the Get call has status code 201
      * configure retry = {count : 5, interval : 200}
      Given path "articles"
      Given params {limit : 10, offset : 0}
      Given header Authorization = authToken
      And retry until response.status == 201
      When method Get