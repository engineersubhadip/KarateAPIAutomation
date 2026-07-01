
Feature: End to end scenario, encompassing everything

    Background: Preconditions
        Given url baseURL
        * def token = callonce read("classpath:helpers/CreateToken.feature")
        * def authToken = token.userToken

    Scenario: Favorite articles
        # Step 1: Get atricles of the global feed
        Given path "articles"
        Given header Authorization = authToken
        Given params {limit : 10, offset : 0}
        When method Get
        Then status 200
        # # Step 2: Get the favorites count and slug ID for the first arice, save it to variables
        * def firstSlugID = response.articles[0].slug;
        * def firstFavCount = response.articles[0].favoritesCount;
        * def expectedFavCount = firstFavCount + 1
        # # Step 3: Make POST request to increse favorites count for the first article
        Given path `articles/${firstSlugID}/favorite`
        Given header Authorization = authToken
        Given request
            """
            {}
            """
        When method Post
        Then status 200
        # # Step 4: Verify response schema
        And match response ==
            """
            {
            "article": {
            "id": "#ignore",
            "slug": #(firstSlugID),
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "createdAt": "#ignore",
            "updatedAt": "#ignore",
            "favoritesCount": #(expectedFavCount),
            "tagList": "#ignore",
            "author": {
            "username": "#ignore",
            "bio": null,
            "image": "#ignore",
            "following": "#boolean"
            },
            "favorited": "#boolean"
            }
            }
            """
        # # Step 5: Verify that favorites article incremented by 1
        And match response.article.favoritesCount == firstFavCount + 1
        # Step 6: Get all favorite articles
        Given path "articles"
        Given header Authorization = authToken
        Given params {limit : 10, offset : 0}
        When method Get
        * def allFavArticles = response.articles.filter((ele) => ele.favoritesCount > 0)
        # Step 7: Verify response schema
        And match each response.articles ==
            """
            {
                "slug": "#string",
                "title": "#string",
                "description": "#string",
                "body": "#string",
                "tagList": "#ignore",
                "createdAt": "#ignore",
                "updatedAt": "#ignore",
                "favorited": "#boolean",
                "favoritesCount": "#number",
                "author": {
                    "username": "#string",
                    "bio": "#ignore",
                    "image": "#string",
                    "following": "#boolean"
                }
            }
            """
        # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
        And match allFavArticles[*].slug contains firstSlugID

    @Debug
    Scenario: Comment articles
        * def commentJson = read("classpath:testData/commentBody.json")
        * def randomData = read("classpath:helpers/generateRandomData.js")
        * def randomCommentDescription = randomData().generateRandomBody()
        * set commentJson.comment.body = randomCommentDescription
        # Step 1: Get atricles of the global feed
        Given path "articles"
        Given params {limit : 10, offset : 0}
        Given header Authorization = authToken
        When method Get
        Then status 200
        # Step 2: Get the slug ID for the first arice, save it to variable
        * def firstSlugID = response.articles[0].slug
        # Step 3: Make a GET call to 'comments' end-point to get all comments
        Given path `articles/${firstSlugID}/comments`
        Given header Authorization = authToken
        When method Get
        Then status 200
        # * How to add conditionals in your feature file
        * def currentSchemaLength = response.comments.length
        * def captureTargetSchema =
            """
            function (responseLength) {
            if (responseLength == 0) {
            return [karate.read("classpath:schemas/emptyCommentSchema.json"), 0]
            } else {
            return [karate.read("classpath:schemas/filledCommentSchema.json"), 1]
            }
            }
            """
        * def expectedCreds = call captureTargetSchema currentSchemaLength
        * print "DEBUG -> ", actualValue
        # * End of the above
        # Step 4: Verify response schema
        # Step 5: Get the count of the comments array lentgh and save to variable
        * def originalCommentsCount = response.comments.length
        # Step 6: Make a POST request to publish a new comment
        Given path `articles/${firstSlugID}/comments`
        Given header Authorization = authToken
        Given request commentJson
        When method Post
        Then status 200
        * def createdCommentID = response.comment.id
        # Step 7: Verify response schema that should contain posted comment text
        And match response.comment.body == randomCommentDescription
        # Step 8: Get the list of all comments for this article one more time
        Given path `articles/${firstSlugID}/comments`
        Given header Authorization = authToken
        When method Get
        Then status 200
        * def updatedCommentsCount = response.comments.length
        # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)
        And match updatedCommentsCount == originalCommentsCount + 1
        # Step 10: Make a DELETE request to delete comment
        Given path `articles/${firstSlugID}/comments/${createdCommentID}`
        Given header Authorization = authToken
        When method Delete
        Then status 200
        # Step 11: Get all comments again and verify number of comments decreased by 1
        Given path `articles/${firstSlugID}/comments`
        Given header Authorization = authToken
        When method Get
        Then status 200
        * def currentCommentCount = response.comments.length
        And match currentCommentCount == updatedCommentsCount - 1