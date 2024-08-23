require "csv"

class Wines::Synchronizer
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def call
    CSV.foreach(file_path, headers: true) do |row|
      attributes = {
        dataset_id: row[0],
        name: row[1],
        kind: row[2],
        elaborate: row[3],
        grapes: row[4],
        harmonizes: row[5],
        alcohol_by_volume: row[6],
        body: row[7],
        acidity: row[8],
        country_code: row[9],
        region_dataset_id: row[11],
        region_name: row[12],
        winery_dataset_id: row[13],
        winery_name: row[14],
        winery_website_link: row[15],
        vintages: row[16],
      }

      WineCreator.new(attributes).call
    end
  end
end
