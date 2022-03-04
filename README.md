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
- Build a project with Service Oriented Architecture (SOA)

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

## Endpoints
### Users
#### Create a User
This endpoint will:
 - Check to see if the user exists in the db or not
 - It will find or create a record and render a JSON representation of the User record
 - Endpoint is `POST /api/v1/users`
 - accept the following JSON body with only the following fields:
```json
{
  "first_name": "John",
  "last_name": "Doe",
  "email": "jdoe@gmail.com"
}
 ```
 
#### Destroy a User
This endpoint will:
 - Destroy the corresponding record (if found) and any associated data
 - NOT return any JSON body at all, and should return a 204 HTTP status code

### Listings
#### Search Listings
This endpoint will:
 - Find all listings that match the given params.
 - Endpoint is `GET /api/v1/listings/search`
 - Accept the params of `{min_year: 2001, max_year: 2004, make: "Toyota", model: "Camry"}`
 - Response 

### User/Listings
#### Create a userlisting
This endpoint will:
 - Save a listing to a users account.
 - It will create a record and render a JSON representation of the UserListing record
 - Endpoint is `POST /api/v1/users/1/listings`

## Further Project Information
 - [Turing Project Details](https://backend.turing.edu/module3/projects/consultancy/)
 - [Heroku Base URL](https://consultancy-be.herokuapp.com/) (Must add on the rest of the url to see example JSON)

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
