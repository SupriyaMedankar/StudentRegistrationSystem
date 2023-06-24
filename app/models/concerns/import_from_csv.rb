require 'csv'

module ImportFromCsv
  extend ActiveSupport::Concern

  class_methods do
    def import_from_csv(file)
      items = []
      CSV.foreach(file, headers: true) do |row|
        row = row.to_hash
        row['password_confirmation'] ||= row['password']
        items << new(row)
      end

      import(items, batch_size: 1000, validate: true, validate_uniqueness: true)
    end
  end
end