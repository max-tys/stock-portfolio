# README
## About
This app tracks the performance of your stock portfolios.
* Track stocks and equity, funds, ETFs, and more.
* Manage your stock portfolios, holdings, and transactions.
* View metrics like current values and total changes.

## Configuration
This is a Ruby on Rails app that uses PostgreSQL as its database.
1. Install the following items (in this sequence):
    * Ruby 3.1.3 through the Ruby Version Manager (RVM): https://rvm.io/rvm/install.
    * Rails 7.0.4: `gem install rails`.
    * PostgreSQL 12.12: https://www.postgresql.org/download/linux/ubuntu/.
    * Gems (all other dependencies for this project): `bundle install`.
2. Setup the database and relations:
    * Start the PostgreSQL server: `sudo service postgresql start`.
    * Create the PostgreSQL databases: `rails db:create`.
    * Migrate the PostgreSQL databases: `rails db:migrate`.
3. Start the Rails server which listens on port 3000 by default: `rails s` or `rails server`. Open http://localhost:3000 in your browser and you'll see the Rails app running.