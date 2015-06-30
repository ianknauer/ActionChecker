require 'smarter_csv'
require 'date'
require 'csv'
require 'pry'

class DocumentHandler

  def initialize
    load_file
  end

  def load_file
    @file = SmarterCSV.process('data.csv')
  end

  def grab_url
    @date = Date.today.to_s
    @file.each do |row|
      if row[:date_last_successfully_checked].nil?
        @url = row[:url]
        break
      else
        date = row[:date_last_successfully_checked]
        if Date.parse(date) <= Date.parse(@date)
          @url = row[:url]
          @date = date
        end 
      end
    end
    add_url_to_file
    @url
  end

  def add_url_to_file
    updated_row = @file.find { |h| h[:url] == "#{@url}"}
    updated_row[:date_last_successfully_checked] = Time.now.strftime("%d-%m-%Y")
  end

  def create_csv
    CSV.open('testdata.csv', 'wb') do |csv|
      csv << ["Url","Date Last successfully checked"]
      @file.each do |row|
        csv << ["#{row[:url]}", "#{row[:date_last_successfully_checked]}"]
      end
    end
    overwrite_data_file
  end

  def overwrite_data_file
    File.rename('testdata.csv', 'data.csv')
  end

end