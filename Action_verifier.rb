require_relative 'lib/website_scraper'
require_relative 'lib/salesforce'
require_relative 'lib/doc_handler'

require 'pry'

writer = DocumentHandler.new
url = writer.grab_url
writer.create_csv
action = WebsiteScraper.new(url)
results = action.run
sleep(300)
db = SalesforceConnection.new
result = db.check_email(results[:email],results[:first_name],results[:last_name],results[:postal_code])
puts result