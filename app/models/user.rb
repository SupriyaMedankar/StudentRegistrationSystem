class User < ApplicationRecord

  include GenerateCsv
  include ImportFromCsv

  rolify

  has_secure_password

  has_one_attached :photo

  validates :name, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: :password_digest_changed?
  validates :dob, presence: true, comparison: { less_than: Date.today.advance(years: -3) }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 254 }  
  validates :address, presence: true

  after_save :send_activation_email, if: :send_activation_email?

  scope :students, -> { without_role(:admin) }
  scope :admin, -> { with_role(:admin) }
  scope :export_records, -> { students }
  scope :active,->{ where(active: true) }

  def admin?
    has_role?(:admin)
  end

  def self.export_data_column
    [:id, :name, :email, :address, :dob]
  end

  private

  def send_activation_email
    UserMailer.with(user: self).account_activated.deliver_later
  end

  def send_activation_email?
    active == true && previous_changes.keys.include?('active')
  end
end
