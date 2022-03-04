# MarketMap: A Turing 2110 BE Mod 3 Consultancy Project

![languages](https://img.shields.io/github/languages/top/Turing-MarketMap/market-map?color=red)
![PRs](https://img.shields.io/github/issues-pr-closed/Turing-MarketMap/market-map)
![rspec](https://img.shields.io/gem/v/rspec?color=blue&label=rspec)
![simplecov](https://img.shields.io/gem/v/simplecov?color=blue&label=simplecov) <!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/contributors-6-orange.svg?style=flat)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->


## Background & Description:

"MarketMap" is a group project built over the course of two weeks in Turing's module 3 backend program. This project is a branch of Turing's Consultancy project. We pitched a rough concept of creating an application that would let a user search for cars and enable them to know if they were getting a good deal based on several factors. See below for more details on the backend features.

## Backend Features
- Exposing internal APIs for Market Map's Frontend.
- Import simulated db with a CSV file (could also be replaced by consuming a third party API)
- Implement CircleCI
- Build a project with Service Oriented Architecture (SOA)
- Train and deploy a series of ANN regressors that predict the expected price of a specific car model.

## Requirements and Setup (for Mac):
### Ruby and Rails
- Ruby -V 2.7.2
- Rails -V 5.2.6

### Gems Utilized
- rspec
- pry
- simplecov
- factory_bot_rails
- faker
- jsonapi-serializer
- ruby-fann
- daru

### Setup
1. Fork and/or Clone this Repo from GitHub.
2. In your terminal use `$ git clone <ssh or https path>`
3. Change into the cloned directory using `$ cd market-map`
4. Install the gem packages using `$ bundle install`
5. Database Migrations can be setup by running:
```shell
$ rails rake db:{drop,create,migrate,seed}
```
6. Populate the database using `$ rake import_listings_csv`
7. Startup and Access require the server to be running locally and a web browser opened.
  - Start Server
```shell
$ rails s
```
 - Open Web Broswer and visit http://localhost:3000/
   - Please visit below endpoints to see JSON data being exposed

## Testing
 - Test using the terminal utilizing RSpec
 ```shell
 $ rspec spec/<follow directory path to test specific files>
 ```
   or test the whole suite with `$ rspec`

## Database Schema
<img width="990" alt="Screen Shot 2022-03-03 at 8 42 11 PM" src="https://user-images.githubusercontent.com/83426676/156695189-dac08144-b2b1-4e72-8295-b526e219add2.png">

## Internal API Endpoints
### Listings
 - Search (All Listings)
   - View listings (with optional filters)
   - Params:
     - `min_year` Minimum Year - data type `integer` - set by params
     - `max_year` Maximum Year - data type `integer` - set by params
     - `make` Car Make - data type `string` - set by params
     - `model` Car Model - data type `string` - set by params
   - Example params: `{min_year: 2001, max_year: 2004, make: "Toyota", model: "Camry"}`
   - Example HTTP Request: `GET https://consultancy-be.herokuapp.com/api/v1/listings/search`
   - HTTP Response 200.
   - Example Response:
```json
{
  "data": [
    {
      "id": "1",
      "type": "listing",
      "attributes": {
        "year": 2014,
        "make": "Acura",
        "model": "ILX",
        "trim": "Technology Package",
        "body": "Sedan",
        "transmission": "automatic",
        "vin": "19vde1f70ee008913",
        "state": "ca",
        "condition": 2.5,
        "odometer": 9051,
        "color": "gray",
        "interior": "black",
        "sellingprice": 21250
       }
    },
    {
      "id": "2",
      "type": "listing",
      "attributes": {
        "year": 2014,
        "make": "Acura",
        "model": "MDX",
        "trim": "Advance and Entertainment Packages",
        "body": "SUV",
        "transmission": "automatic",
        "vin": "5fryd3h83eb011004",
        "state": "ca",
        "condition": 4.9,
        "odometer": 21523,
        "color": "white",
        "interior": "gray",
        "sellingprice": 41500
      }
     },...
```

- Show (Get Listing)
   - View a listing (with optional filters)
   - Example HTTP Request: `GET https://consultancy-be.herokuapp.com/api/v1/listings/:id`
   - HTTP Response 200.
   - Example Response:
```json
{
  "data": {
    "id": "1",
    "type": "listing",
    "attributes": {
      "year": 2014,
      "make": "Acura",
      "model": "ILX",
      "trim": "Technology Package",
      "body": "Sedan",
      "transmission": "automatic",
      "vin": "19vde1f70ee008913",
      "state": "ca",
      "condition": 2.5,
      "odometer": 9051,
      "color": "gray",
      "interior": "black",
      "sellingprice": 21250
      }
    }
}
```

### Users
- Find/Create User
  - Verifies if the user exists in the DB, if it exists return user data.
  - If the user does not exist, create a new DB entry and return confirmation and new user data.
  - Required Params:
    - `email` User Email - data type `string` - set by params
    - `first_name` User first name - data type `string` - set by params
    - `last_name` User last name - data type `string` - set by params
  - Example Params: `{"first_name": "John", "last_name": "Doe", "email": "jdoe@gmail.com"}`
  - Example HTTP Request: `POST https://https://consultancy-be.herokuapp.com/api/v1/users`
  - HTTP Response 200.
  - Example Response:
```json
{
  "data": {
    "id": "1",
    "type": "user",
    "attributes": {
      "first_name": "Tommy",
      "last_name":"Bartell",
      "email": "bartell_tommy@example.net"
    }
  }
}
```

- Destroy User
  - Destroy the corresponding record (if found) and any associated data
  - Required Params:
    - `id` User ID - data type `string` - set by params
  - Example Request: `DELETE https://https://consultancy-be.herokuapp.com/users/:id`
  - HTTP Response 204.

### UserListings
- Create User Listing
  - Save a listing to a users account.
  - It will create a record and render a JSON representation of the UserListing record
  - Required Params:
    - `user_id` User ID - data type `integer` - currently signed in user id
    - `listing_id` Listing ID - data type `integer` - listing ID to be added to users saved listings
  - Example HTTP Request: `POST https://https://consultancy-be.herokuapp.com/api/v1/users/:user_id/listings`
  - HTTP Response 200.
  - Example Response:
```json
{
  "data": [{
    "id": "1",
    "type": "listing",
    "attributes": {
      "year": 2014,
      "make": "Acura",
      "model": "ILX",
      "trim": "Technology Package",
      "body":"Sedan",
      "transmission": "automatic",
      "vin": "19vde1f70ee008913",
      "state": "ca",
      "condition": 2.5,
      "odometer": 9051,
      "color": "gray",
      "interior": "black",
      "sellingprice": 21250
      }
    }, {
    "id": "1",
    "type": "listing",
    "attributes": {
      "year": 2014,
      "make": "Acura",
      "model": "ILX",
      "trim": "Technology Package",
      "body": "Sedan", "transmission": "automatic",
      "vin": "19vde1f70ee008913",
      "state": "ca",
      "condition": 2.5,
      "odometer": 9051,
      "color": "gray",
      "interior": "black",
      "sellingprice": 21250
    }
  } ...
```
- Destroy User
  - Delete a users account.
  - Example Request: `DELETE https://https://consultancy-be.herokuapp.com/api/v1/users/:user_id/listings`
  - Required Params:
    - `user_id` User ID - data type `integer` - currently signed in user id
    - `listing_id` Listing ID - data type `integer` - listing ID to be added to users saved listings
  - HTTP Response 204.

### Fair Price Trendline
- Get FairPrice
 - Return the predicted price of a given model at a given mileage.
 - Endpoint is `GET /api/v1/fair_price`
 - Accept the params of `{model: "Outback", mileage: [10000, 50000, 100000]}`
 - Response is a json tha includes an array of integers representing price.

## Further Project Information
 - [Turing Project Details](https://backend.turing.edu/module3/projects/consultancy/)
 - [Heroku Base URL](https://consultancy-be.herokuapp.com/) (Must add on the rest of the url to see example JSON)
 - [Frontend Heroku Market Map Repo](https://github.com/Turing-MarketMap/market-map-fe)

## **Contributors** ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/croixk"><img src="https://avatars.githubusercontent.com/u/20864043?s=96&v=4" width="100px;" alt=""/><br /><sub><b>Croix (he/him)</b></sub></a><br /><a href="https://github.com/Turing-MarketMap/market-map/commits?author=croixk" title="Code">💻</a> <a href="#ideas-croixk" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/Turing-MarketMap/market-map/commits?author=croixk" title="Tests">⚠️</a> <a href="https://github.com/Turing-MarketMap/market-map/pulls?q=is%3Apr+reviewed-by%3Ajcroixk" title="Reviewed Pull Requests">👀</a></td>
    <td align="center"><a href="https://github.com/Eldridge-Turambi"><img src="https://avatars.githubusercontent.com/u/87398716?s=96&v=4" width="100px;" alt=""/><br /><sub><b>Eldridge (he/him)</b></sub></a><br /><a href="https://github.com/Turing-MarketMap/market-map/commits?author=Eldridge-Turambi" title="Code">💻</a> <a href="#ideas-Eldridge-Turambi" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/Turing-MarketMap/market-map/commits?author=Eldridge-Turambi" title="Tests">⚠️</a> <a href="https://github.com/Turing-MarketMap/market-map/pulls?q=is%3Apr+reviewed-by%3AjEldridge-Turambi" title="Reviewed Pull Requests">👀</a></td>  
    <td align="center"><a href="https://github.com/jacksonvaldez"><img src="https://avatars.githubusercontent.com/u/87635398?s=96&v=4" width="100px;" alt=""/><br /><sub><b>Jackson (he/him)</b></sub></a><br /><a href="https://github.com/Turing-MarketMap/market-map/commits?author=jacksonvaldez" title="Code">💻</a> <a href="#ideas-jacksonvaldez" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/Turing-MarketMap/market-map/commits?author=jacksonvaldez" title="Tests">⚠️</a> <a href="https://github.com/Turing-MarketMap/market-map/pulls?q=is%3Apr+reviewed-by%3Ajjacksonvaldez" title="Reviewed Pull Requests">👀</a></td>
    <td align="center"><a href="https://github.com/LelandCurtis"><img src="https://avatars.githubusercontent.com/u/15107515?s=96&v=4" width="100px;" alt=""/><br /><sub><b>Leland (he/him)</b></sub></a><br /><a href="https://github.com/Turing-MarketMap/market-map/commits?author=LelandCurtis" title="Code">💻</a> <a href="#ideas-LelandCurtis" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/Turing-MarketMap/market-map/commits?author=LelandCurtis" title="Tests">⚠️</a> <a href="https://github.com/Turing-MarketMap/market-map/pulls?q=is%3Apr+reviewed-by%3AjLelandCurtis" title="Reviewed Pull Requests">👀</a></td> 
    <td align="center"><a href="https://github.com/tjroeder"><img src="https://avatars.githubusercontent.com/u/78194232?s=96&v=4" width="100px;" alt=""/><br /><sub><b>Tim (he/him)</b></sub></a><br /><a href="https://github.com/Turing-MarketMap/market-map/commits?author=tjroeder" title="Code">💻</a> <a href="#ideas-tjroeder" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/Turing-MarketMap/market-map/commits?author=tjroeder" title="Tests">⚠️</a> <a href="https://github.com/Turing-MarketMap/market-map/pulls?q=is%3Apr+reviewed-by%3Ajtjroeder" title="Reviewed Pull Requests">👀</a></td>   
    <td align="center"><a href="https://github.com/kevingloss"><img src="https://avatars.githubusercontent.com/u/83426676?s=96&v=4" width="100px;" alt=""/><br /><sub><b>Kevin (he/him)</b></sub></a><br /><a href="https://github.com/Turing-MarketMap/market-map/commits?author=kevingloss" title="Code">💻</a> <a href="#ideas-kevingloss" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/Turing-MarketMap/market-map/commits?author=kevingloss" title="Tests">⚠️</a> <a href="https://github.com/Turing-MarketMap/market-map/pulls?q=is%3Apr+reviewed-by%3Ajkevingloss" title="Reviewed Pull Requests">👀</a></td>
    
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification.
<!--
