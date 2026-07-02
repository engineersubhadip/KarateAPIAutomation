
Feature: Home Work

    Background: Preconditions
        * url baseURL
        * def token = callonce read("classpath:helpers/CreateToken.feature")
        * def authToken = token.userToken

    Scenario: Favorite articles
        # Step 1: Get atricles of the global feed
        Given path "articles"
        Given params {limit : 10, offset : 0}
        Given header Authorization = authToken
        When method Get
        # Step 2: Get the favorites count and slug ID for the first arice, save it to variables
        * def firstArtFavCount = response.articles[0].favoritesCount
        * def firstArtSlugID = response.articles[0].slug
        # Step 3: Make POST request to increse favorites count for the first article
        Given path `articles/${firstArtSlugID}/favorite`
        Given request
            """
            {}
            """
        Given header Authorization = authToken
        When method Post
        # Step 4: Verify response schema
        * def increaseFavCountSchema = read("classpath:schemas/favCountPostReq.json")
        Then match response == increaseFavCountSchema
        # Step 5: Verify that favorites article incremented by 1
        * def currentFavCount = response.article.favoritesCount
        And match currentFavCount == firstArtFavCount + 1
        # Step 6: Get all favorite articles
        Given path "articles"
        * def queryParams =
            """
            {
            favorited : #(userName),
            limit : 10,
            offSet : 0
            }
            """
        Given params queryParams
        Given header Authorization = authToken
        When method Get
        Then status 200
        * def listOfAllFavArtSchema = read("classpath:schemas/listOfAllFavArtSchema.json")
        # Step 7: Verify response schema
        And match each response.articles == listOfAllFavArtSchema
        # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
        And match response.articles[*].slug contains firstArtSlugID