require 'csv'

module ImportFromCsv
  extend ActiveSupport::Concern

  class_methods do
    def import_from_csv(file)
      CSV.foreach(file, headers: true) do |row|
        data = row.to_hash
        data = { 'password_confirmation' => data['password'], 'active' => false }.merge(data)
        User.where(email: data[:email]).first_or_create(data)
      end
    end
  end
end