## Built With

- Ruby v3.1
- Ruby on Rails v7.0.4
- RSpec-Rails for testing


## API Details

### API doc
https://documenter.getpostman.com/view/24985944/2s8YzZQeVq



### Current API Endpoints
The API will expose the following RESTful endpoints.

> BaseUrl: {Host-URL}/api/v1

| Endpoint                         | Functionality                |
|----------------------------------|------------------------------|
| POST /register                   | Signup                       |
| POST /login                      | Login                        |
| GET /books                       | Get all books                |
| GET /books/:id                   | Get a bppl                   |
| POST /books                      | Add a new book               |
| DELETE /books/:id                | Delete a book                |
| PUT /books/:id                   | Update a book                |
| POST /categories                 | Add category                 |
| GET /categories                  | Get categories               |
| GET /books/_id/reviews           | Get reviews of a book        |
| POST /books/_id/reviews          | Create review for a book     |
| PUT /books/_id/reviews/_id       | Update review for a book     |
| DELETE /books/_id/reviews/_id    | Delete a review              |


## Setup

~~~bash
$ git clone git@github.com:Arpanbhagat5/bookhouse.git
$ cd bookhouse
~~~

Install gems with:

```
bundle install
```

Setup database with:

> In case of default sqlite3, no added setup required.
> In case of Postgres, make sure you have postgress sql installed and running on your system

```
   rails db:create
   rails db:migrate
   rails db:seed -> No seeds at the moment
```

## Usage

Start server with:

```
    rails server
```

Open `http://localhost:3000/` in your browser.

## Run tests

```
    rpsec
    OR
    bundle exec rspec
```

## Todo/things to try

- 95%+ test coverage
- DRY code
- Try new features of rails (ther's a lot)
- ORM immprovements
- Pagination for API
- Best practice: API versioning
- Deactivate records with a flag for DELETE endpoints
- Eager loading for N+1 queries


## Deploy to a live server (Boilerplate code)

Deploying to a live server like Heroku is easy, make sure you have the necessary credentials setup on your local machine

```bash
heroku create
heroku rename app-new-name
git push heroku $BRANCH_NAME:master 
```
if you are already in master branch no need to add $BRANCH_NAME, just use `git push heroku master`

```bash
heroku run rails db:migrate
heroku run rails db:seed
heroku open
```

## Extra Refs

### ERD

![alt text](https://github.com/Arpanbhagat5/bookhouse/blob/c36ed63106578a05cc7a2c728781b980fc93ffc5/erd.png)
