Feature: Articles

   Background: Capturing the user token during login process
      Given url baseURL
      * def authToken = callonce read('classpath:helpers/CreateToken.feature')
      * def token = authToken.userToken
      * def requestBody = read('classpath:testData/newArticleBody.json');
      * def randomData = read("classpath:helpers/generateRandomData.js");
      * def randomTitle = randomData().generateRandomTitle();
      * def randomDescription = randomData().generateRandomDescription();
      * def randomBody = randomData().generateRandomBody();
      * set requestBody.article.title = randomTitle
      * set requestBody.article.description = randomDescription
      * set requestBody.article.body = randomBody


   Scenario: Creating article
      Given path "articles/"
      Given header Authorization = token
      Given request  requestBody
      When method Post
      Then status 201
      And match response.article.title == randomTitle
      And match response.article.description == randomDescription

   Scenario: Deleting the an article
      # User will first create the article and then delete the same article and verify it has been deleted
      Given path "articles/"
      Given header Authorization = token
      Given request requestBody
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
      And match currentListOfArticles contains randomTitle

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
      And match updatedListOfArticles !contains randomTitle
