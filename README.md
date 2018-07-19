# Quake Log Parser
[![CircleCI](https://circleci.com/gh/andrerpbts/quake_log_parser.svg?style=svg&circle-token=74a357d0cf55989c74cf142f907fd060ae48d1c1)](https://circleci.com/gh/andrerpbts/quake_log_parser)

## About

Quake Log parser API for Magazine Luiza test.

## Getting Started

First up, your system will need the
[prerequisites for running Ruby on Rails installed](http://railsinstaller.org/en)

Once you have these:

    # Checkout the project
    $ git clone git://github.com/andrerpbts/quake_log_parser
    $ cd quake_log_parser

    # copy and edit the configuration
    $ cp config/database.sample.yml config/database.yml

    # Install the project dependencies
    $ gem install bundler
    $ bundle install

    # Set up the development database
    $ bundle exec rails db:setup

    # Start the local web server
    $ rails s

    # Run the test suite
    $ bundle exec rspec
    $ bundle exec rubocop

To manage the API data, access the `/admin` route. The development admin user is:

    # Email: admin@example.com
    # Password: 123456

The API documentation is at project root, in a file named `apiary.apib`. This file is in [API Blueprint](https://apiblueprint.org/) format and
it's fully compatible with [Apiary](https://apiary.io) service.

## License

Copyright 2018 - André Rodrigues.
