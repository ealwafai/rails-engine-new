# Rails Engine

## Table of Contents

- [About this Project](#about-this-project)
- [Learning Goals](#learning-goals)
- [Local Setup](#local-setup)
- [Project Configurations](#project-configurations)
- [Database Schema](#database-schema)
- [Tools Used](#tools-used)
- [Contributors](#contributors)

## About this Project

Rails Engine is a 1 week, single person project, during Mod 3 of 4 for Turing School's Back End Engineering Program.

The scenario is that I am working for a company developing an E-Commerce Application. The team is working in a service-oriented architecture, meaning the front and back ends of this application are separate and communicate via APIs. My job is to expose the data that powers the site through an API that the front end will consume.

Find the project spec [here](https://backend.turing.edu/module3/projects/rails_engine/)

## Learning Goals

* Expose an API ⭐ ⭐ ⭐
* Use serializers to format JSON responses ⭐ ⭐ ⭐
* Test API exposure ⭐ ⭐ ⭐
* Compose advanced ActiveRecord queries to analyze information stored in SQL databases ⭐ ⭐
* Write basic SQL statements without the assistance of an ORM ⭐

## Local Setup

This project requires Ruby 2.7.2.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
`bundle`
`bundle update`
`rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Project Configurations
* Ruby version
```
$ ruby -v
ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-darwin20]
```

* System dependencies
```
$ rails -v
Rails 5.2.6
```

* Database creation
```
$ rails db:{drop,create,migrate,seed}
...
$ rails db:schema:dump
```

* How to run the test suite
```
$ bundle exec rspec
```

* Local Deployment, for testing:
```
$ rails s
=> Booting Puma
=> Rails 5.2.6 application starting in development
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.12.6 (ruby 2.7.2-p137), codename: Llamas in Pajamas
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://localhost:3000
Use Ctrl-C to stop
```

## Database Schema

<img width="1421" alt="Screen Shot 2021-10-28 at 2 18 37 PM" src="https://user-images.githubusercontent.com/77654906/139321317-91e062e3-91c2-4787-b568-89481ca47515.png">

 
## Tools Used

| Development | Testing       | Gems          |
|   :----:    |    :----:     |    :----:     |
| Ruby 2.7.2  | RSpec         | SimpleCov     |
| Rails       | Rubocop       | Pry           |
| HTML5       |               | Bootstrap     |
| CSS3        |               | ShouldaMatcher|
| Github      |               | VCR           |
| Atom        |               | Figaro        |
| Postman     |               | PostgresQL    |
| Travis      |               | Postico       |
|             |               | Faker         |
|             |               | Factorybot    |
|             |               | Faraday       |
|             |               | Bcrypt        |
|             |               |               |
|             |               |               |


## Contributors

👤  **Ezzedine Alwafai**
- [GitHub](https://github.com/ealwafai)
- [LinkedIn](https://www.linkedin.com/in/ezzedine-alwafai/)
