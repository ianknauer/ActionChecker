require 'restforce'
require 'pry'

class SalesforceConnection
  def initialize
    @client = Restforce.new :username => ENV['username'],
      :password => ENV['password'],
      :security_token => ENV['security_token'],
      :client_id => ENV['client_id'],
      :client_secret => ENV['client_secret']
  end

  def check_email(email, firstName, lastName, postalCode)
    result = @client.find('contact', email, "email")
    if result.FirstName == firstName && result.LastName == lastName && result.Email == email && result.MailingPostalCode == postalCode.upcase
      "success"
    else return
    end
  end
end