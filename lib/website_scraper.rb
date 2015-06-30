require 'open-uri'
require 'mechanize'

class WebsiteScraper

  def initialize(url)
    @url = url
    @info = Hash.new
    @agent = Mechanize.new
  end

  def run
    get_form
    fill_out_form
    @info
  end

  def get_form
    content = @agent.get(@url)
    @form = content.forms.first
  end

  def get_form_fields
    fielders = Array.new
    @form.fields.each do |field| 
      if field.name.to_s.include?("[und]")
        fielders << field
      end
    end
    fielders
  end

  def fill_out_form
    fields = get_form_fields
    fill_out_fields(fields)
    @form.submit
  end

  def fill_out_fields(fields)
    fields.each do |field|
      case
      when field.name.include?("first_name")
        @form["#{field.name}"] = "test"
      when field.name.include?("last_name")
        @form["#{field.name}"] = "Testerson"
      when field.name.include?("email")
        @form["#{field.name}"] = "#{Time.now.strftime("%m%d%Y")}@davidsuzuki.org"
      when field.name.include?("postal_code")
        @form["#{field.name}"] = "v3h4x9"
      end
    end 
    @info = {first_name: "test", last_name: "Testerson", email: "#{Time.now.strftime("%m%d%Y")}@davidsuzuki.org", postal_code: "v3h4x9"}
  end
end