require 'restforce' #salesforce gem
#require 'pry'

class SalesforceConnection
  def initialize # creates our client out of the environment variables that are set for our salesforce instances
    @client = Restforce.new :username => ENV['username'],
      :password => ENV['password'],
      :security_token => ENV['security_token'],
      :client_id => ENV['client_id'],
      :client_secret => ENV['client_secret']
  end

  def check_email(email, firstName, lastName, postalCode) #looks for a contact with the email that we provide, checks if values are actually the same in salesforce. These fields are overwritten by Action platform on submit, so if this isn't the case something is broken.
    result = @client.find('contact', email, "email")
    if result.FirstName == firstName && result.LastName == lastName && result.Email == email && result.MailingPostalCode == postalCode.upcase
      "success #{result.FirstName} #{result.LastName} at #{result.Email} is in salesforce"  #returns upon check_email
    else return
    end
  end
end
