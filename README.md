# Stock Portfolio Tracker

## About

The Stock Portfolio Tracker is an app designed to help you track the performance of your stock portfolios. With this app, you can easily manage your stock portfolios, holdings, and transactions. You can also view metrics such as current values and total changes to help you make informed decisions.

## Configuration

This app is built with Ruby on Rails and uses PostgreSQL as its database. Follow these steps to set up the app:

1. Install the following items in this sequence:

   - Ruby 3.2.2 through rbenv (preferred) or rvm.
   - Rails 7.0.8: `gem install rails`.
   - PostgreSQL 14.
   - Gems (all other dependencies for this project): `bundle install`.

2. Setup the database and relations:

   - Start the PostgreSQL server: `sudo service postgresql start`.
   - Create the PostgreSQL databases: `rails db:create`. Make sure the superuser has granted the privilege to create databases ("CREATEDB") to the selected user.
   - Migrate the PostgreSQL databases: `rails db:migrate`.

3. Get a free API from Finnhub and save it in Rails by running `rails credentials:edit`. Use `finnhub` as the namespace, and save the API as `api_key` under `finnhub`.

4. Start the Rails server:

   - The server listens on port 3000 by default.
   - To start the server, run `rails s` or `rails server`.
   - Open http://localhost:3000 in your browser and you'll see the Rails app running.
