# URL Shortener Exercise

## Requirements
* npm
* elixir 1.9 (older versions might not work)
* erlang OTP 22
* docker

## Running the code
make {setup|server|test} are expected to work as expected :)
* make setup npm installs react and axios  builds images both React and Elixir apps
* make server runs images togther with Postgres
* make test runs Elixir app tests

## Endpoints
* on successful run application can be accessed at "http://localhost:3000"
* Elixir Plug router is exposed at "http://localhost:4001". It is reachable from the outside on puprpose. Available API calls:
  * GET /alive -> should return "1" in plain text if router is up N running
  * GET /short_url?url=sample.com -> converts long url and returns shortcode
  * GET /__shortcode__ -> router to "consume" short url and get redirected
* Postgres is available on port 5432 also on purpose

## Solution aproach
* I found base62 encoding the most suitable solution for this problem. Each url should get the unique sequential id when stored and base62 representation of that url is the shortcode to use for redirection.
As the simplest solution I took relational database with just one table and autoincremented ids hoping that it can provide enough capacity for V1 solution. Definetly database is expected to become the botleneck first and should eventually be replaced with some other source for generating unique ids (eg. service which serves API(s) with batches of available ids.)
* I didn't pay too much atention about input url validation. Simple validation is implemented but it is expected that if user provides invalid url it will be redirected to that invalid url. This could be improved.
* My "design part" took the weekend off so UI is quite rudimental (hoping the backend part would compensate that)
* secrets are quite simple and are included in the repository but that wouldn't be the case for any serious development - all secrets would have beend stored securely and provided using enviroment vars
* It took me about 2 hours to do the backend, about 4 hours to figure out basics of React as I had no previous experience and I spent little more then one hour preparing docker files, make files and writing this notes (I had a typo in Dockerfile path which took me a while to figure out)


