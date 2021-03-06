# README

## Lending Tree Review Service <br />
This service takes a url from a request and responds with an array of all the reviews associated with that url from lendingtree.com. If the url does not exist in the database, the data is collected with a webscrapper and then cached in the PostgreSQL database. If the url is called again, the data is retrieved from the database.

## Possible Second Idea for Webservice to Improve Speed<br />
Initially, I tried to find API endpoints to collect all the reviews for a given url. However, LendingTree does not have a publicly available API. So I started to search the chrome dev tools for publicly available API endpoints. There is actually an API endpoint that you can get json for specific Lenders: https://www.lendingtree.com/content/mu-plugins/lt-review-api/review-api-proxy.php?RequestType=&productType=&brandId=27085&requestmode=reviews,stats,ratingconfig,propertyconfig&page=0&sortby=reviewsubmitted&sortorder=desc&pagesize=10&AuthorLocation=All&_t=1566185572884. Perhaps in the second iteration of this project, I would use this API endpoint instead of webscrapping. The one issue with this endpoint is that you need the brandId, which is difficult to find.

## The API Specifications<br />
    1. Request Type: POST
    2. Route: ROOT/lending_tree/fetch_reviews
    3. Parameters in the body of the request
        a. url
            1. DATA_TYPE: string
            2. REQUIREMENT: the url must start with https://www.lendingtree.com/reviews/ otherwise you will get an error message with a status of 400
            3. If the part of url after https://www.lendingtree.com/reviews/ is incorrect, you will receive an error message with a status of 404
    
## Example Request Body<br />
```
{
	"url": "https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183"
}
```

## Example Response Body 1<br />

```
{
    reviews: [
        {
            "total_rating": "5",
            "title": "Best",
            "content": "Best decision i could have made. Kind agent very precise and friendly help. She gave us plenty of options that worked best for our family..",<br />
            "author": "Oneal from DECATUR, IL ",
            "review_date": "Reviewed in August 2019"
        }
    ]
}
```

## Example Response Body 2<br />
```
{
    "reviews": [
        {
            "title": "awesome",
            "content": "I have had great experience with Mandy and She answered all my questions with rapid response. Great customer service and helped me through out the Loan process with speed and accuracy. thank U again Mandy!!",
            "total_rating": 5,
            "review_date": "March 2016",
            "author": {
                "name": "Patrick"
            }
        },
    ]
}
```

## API Tech Stack<br />
1. Ruby 2.5.1<br />
2. Ruby on Rails 5.2.3<br />
3. PostgreSQL 10.3<br />
4. Sidekiq 5.2.7<br />
5. Redis 5.0.5<br />
6. RSpec 3.8<br />
7. Nokogiri 1.10.4<br />
