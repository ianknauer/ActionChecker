require 'smarter_csv' #library for dealing with CSV's that's nicer to deal with than the build in Ruby CSV parser
require 'date' #needed for date for filename
require 'csv' #ruby default, use for creating document
#require 'pry'

class DocumentHandler

  def initialize #runs when DocumentHandler is created
    load_file
  end

  def load_file #loads all data from data.csv
    @file = SmarterCSV.process('data.csv')
  end

  def grab_url #grabs the url that was least recently checked, or one that is empty
    @date = Date.today.to_s
    @file.each do |row|
      if row[:date_last_successfully_checked].nil? #new urls get added with no value in the :date_last_successfully_checked row, this will them first
        @url = row[:url]
        break #set url and then break out of the .each
      else
        date = row[:date_last_successfully_checked]
        if Date.parse(date) <= Date.parse(@date)
          @url = row[:url]
          @date = date
        end
      end
    end
    add_url_to_file
    @url #returns the url when DocumentHandler.grab_url has been run.
  end

  def add_url_to_file
    updated_row = @file.find { |h| h[:url] == "#{@url}"} #finds the correct url in file
    updated_row[:date_last_successfully_checked] = Time.now.strftime("%d-%m-%Y") #updates the last checked date to be when this was run
  end

  def create_csv #takes @file and puts all the new info into a csv called testdata.csv
    CSV.open('testdata.csv', 'wb') do |csv|
      csv << ["Url","Date Last successfully checked"]
      @file.each do |row|
        csv << ["#{row[:url]}", "#{row[:date_last_successfully_checked]}"]
      end
    end
    overwrite_data_file #renames testdata.csv to data.csv, which is what it intially loads from
  end

  def overwrite_data_file
    File.rename('testdata.csv', 'data.csv')
  end

end
