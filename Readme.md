# About

This bit of code is meant to be run once a week to test and make sure the action platform is dumping people (and their first name, last name, email address, and postal code) into salesforce correctly.

# How to use

In the root folder you need to create a .env file with the following variables: username,password,security_token,client_id,client_secret. The first three are for your salesforce account, the second two are for a salesforce app license. Talk to Ian if you need help finding any of these out.

Run the command ```bash ruby Action_verifier.rb``` in terminal and the code will spit out results at you as you're going. There's a five minute wait in the middle, which allows the action platform enough time to add the user to salesforce.

# Requirements

* Bundler
* Ruby
* Rubygems

# To Do's

* Remove contacts from salesforce after you create them
* Read write to google doc instead of csv file?
