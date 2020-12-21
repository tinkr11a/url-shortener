# URL Shortener Exercise

## Requirements
* npm
* elixir 1.9 (older versions might not work)
* erlang OTP 22
* docker

## Running the code
make {setup|server|test} are expected to work as expected
* make setup npm installs React and Axios  builds images both React and Elixir apps
* make server runs images together with Postgres
* make test runs Elixir app tests

## Endpoints
* on the successful run application can be accessed at "http://localhost:3000"
* Elixir Plug router is exposed at "http://localhost:4001". It is reachable from the outside on purpose. Available API calls:
  * GET /alive -> should return "1" in plain text if the router is up N running
  * GET /short_url?url=sample.com -> converts long URL and returns shortcode
  * GET /__shortcode__ -> router to "consume" short URL and get redirected
* Postgres is available on port 5432 also on purpose

## Solution approach
* I found base62 encoding the most suitable solution for this problem. Each URL should get the unique sequential id when stored and base62 representation of that URL is the shortcode to use for redirection.
As the simplest solution, I took relational database with just one table and autoincremented ids hoping that it can provide enough capacity for V1 solution. Definitely database is expected to become the botleneck first and should eventually be replaced with some other source for generating unique ids (eg. service which serves API(s) with batches of available ids.)
* I didn't pay too much attention about input URL validation. Simple validation is implemented but it is expected that if the user provides invalid URL it will be redirected to that invalid URL. This could be improved.
* My "design part" took the weekend off so UI is quite rudimental (hoping the backend part would compensate that)
* secrets are quite simple and are included in the repository but that wouldn't be the case for any serious development - all secrets would have been stored securely and provided using environment vars
* I didn't implement any scripts for the Elixir app waiting on the database and the React app wating on Elixir app. I just added "depends on" in docker compose and it worked fine for me as many times as I tried to start it. Both database and Elixir start very fast so it seems to me there should be no problems
* It took me about 2 hours to do the backend, about 4 hours to figure out basics of React as I had no previous experience and I spent little more than one hour preparing docker files, make files and writing this notes (I had a typo in Dockerfile path which took me a while to figure out)


