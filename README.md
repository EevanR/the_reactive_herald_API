# The Reactive Herald API

[![Coverage Status](https://coveralls.io/repos/github/CraftAcademy/the_reactive_herald_API/badge.svg?branch=development)](https://coveralls.io/github/CraftAcademy/the_reactive_herald_API?branch=development)

The Reactive Herald is a web applitcation made to function as a online news room. Users can browse short snippets of articles for free or can pay for a subscription to see full articles. Journalists can log on to create their articles and attach an image, which is stored on amazon web services. An article is not publically displayed until it is published by a publisher. Articles are grouped by category and the application's displayed language can be switched between swedish and english if the visitor/user desires.

## Deployed Site
https://the-reactive-herald-ca.netlify.com/

## Dependencies
- Ruby 2.5.1
- Rails 6.0.2
- will_paginate 3.1.0
- devise_token_auth
- pundit
- stripe-rails
- globalize

## To run locally
#### Clone repository
```
$ git clone https://github.com/EevanR/the_reactive_herald_API.git
$ cd the_reactive_herald_API
```

#### Install dependencies
Install Rspec and dependencies
```
$ bundle
```

## Run testing frameworks
In console:
Run Rspec 
```
$ rspec
```

## Actions available to the user

Head to the deployed address listed above, or your local host with frontend running, and have a look around.

Log in as various roles on deployed site to check functionality;

#### To publish articles
Publisher:  
visit: https://the-reactive-herald-ca.netlify.com/admin  
email: publ@mail.com  
pass: password

#### To view full articles as subscriber
Subscriber: 
email: sub@mail.com  
pass: password

#### To write articles as journalist
Journalist:
email: journo@mail.com
pass: password

Or create your own account.

## Updates/Improvement plans
Further styling and functionality.

## License
Created under the <a href="https://en.wikipedia.org/wiki/MIT_License">MIT License</a>.
