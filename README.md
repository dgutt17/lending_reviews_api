# README

Lending Tree Review Service <br />
<space><space>This service takes a url in the body of an http request and returns a response with a json object that contains an array of all the reviews associated with that url. If the url does not exist in the database, the data is received with a webscrapper and then cached in the PostgreSQL database. If the url is called again, the data is received from the database.

Possible Second Idea for Webservice to Improve Speed<br />
<space><space>Initially, I tried to find API endpoints to make http requests to receive json for all the reviews for a given url. However, LendingTree does not have a publicly available API. So I started to search the chrome dev tools for possible API endpoints with data. There is actually an API endpoint that you get json for specific Lenders: https://www.lendingtree.com/content/mu-plugins/lt-review-api/review-api-proxy.php?RequestType=&productType=&brandId=27085&requestmode=reviews,stats,ratingconfig,propertyconfig&page=0&sortby=reviewsubmitted&sortorder=desc&pagesize=10&AuthorLocation=All&_t=1566185572884. So perhaps in the second iteration of this project I would use this API endpoint instead of webscrapping. The one issue with this endpoint is that you need the brandId, which is not readily available. So you could make http requests to this endpoint until you store all the brandIds in your DB. Then match lenders to their brandId and make a request to this endpoint.

The API Specifications<br />
    <space>1. Request Type: POST<br />
    <space>2. URI: http://localhost:3000/lending_tree/fetch_reviews<br />
    <space>3. Parameters in the body of the request<br />
        <space><space>a. url<br />
            <space><space><space>1. string<br />
            <space><space><space>2. REQUIREMENT: the url must start with https://www.lendingtree.com/reviews/ otherwise you will get an error message with a status of 400<br />
            <space><space><space>3. If the part of url after https://www.lendingtree.com/reviews/ is incorrect, you will recieve an error message with a status of 404<br />
    
Example Request<br />
{<br /><space>
	"url": "https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183"
<br />}

Example Response<br />

{
    reviews: [
        {}
    ]
}

API Tech Stack<br />
<space>1. Ruby 2.5.1<br />
<space>2. Ruby on Rails 5.2.3<br />
<space>3. PostgreSQL 10.3<br />
<space>4. Sidekiq 5.2.7<br />
<space>5. Redis 5.0.5<br />
<space>6. RSpec 3.8<br />
<space>7. Nokogiri 1.10.4<br />
