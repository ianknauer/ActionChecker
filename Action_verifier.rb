require_relative 'lib/website_scraper'
require_relative 'lib/salesforce'
require_relative 'lib/doc_handler'

#require 'pry' required only for debugging
require 'dotenv'

Dotenv.load #loads salesforce login info without having info in github.

writer = DocumentHandler.new #doc_handler.rb
url = writer.grab_url #pulls url from data.csv file based on logic within DocumentHandler
puts "scraping #{url}" #not needed, but gives user feedback
writer.create_csv #overwrites csv with new csv
action = WebsiteScraper.new(url) #website_scraper.rb / scrapes the url that we got using mechanize gem
results = action.run
puts "results = #{results}"
puts "now i'm going to sleep for 5 minutes" #the Sync between salesforce and the platform can take up to five minutes to move the person, so we wait for 5 minutes before we look for them.
sleep(300)
#results = {:first_name=>"test", :last_name=>"Testerson", :email=>"07012015@davidsuzuki.org", :postal_code=>"v3h4x9"}

db = SalesforceConnection.new #salesforce.rb /
puts "connected to the Salesforces"
result = db.check_email(results[:email],results[:first_name],results[:last_name],results[:postal_code])
puts result #lets the user know visually if there's a result
