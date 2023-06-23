require 'csv'

module GenerateCsv
  extend ActiveSupport::Concern

  class_methods do
    def generate_csv
      CSV.generate(headers: true) do |csv|
        csv << export_data_column

        export_records.select(export_data_column).find_each do |record|
          csv << record.attributes.values
        end
      end
    end
  end
end