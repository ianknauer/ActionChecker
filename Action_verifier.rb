require_relative 'lib/website_scraper'
require_relative 'lib/salesforce'
require_relative 'lib/doc_handler'

require 'pry'
require 'dotenv'

Dotenv.load

writer = DocumentHandler.new
url = writer.grab_url
puts "scraping #{url}"
writer.create_csv
action = WebsiteScraper.new(url)
results = action.run
puts "results = #{results}"
puts "now i'm going to sleep for 5 minutes"
sleep(300)
#results = {:first_name=>"test", :last_name=>"Testerson", :email=>"07012015@davidsuzuki.org", :postal_code=>"v3h4x9"}

db = SalesforceConnection.new
puts "connected to the Salesforces"
result = db.check_email(results[:email],results[:first_name],results[:last_name],results[:postal_code])
puts result