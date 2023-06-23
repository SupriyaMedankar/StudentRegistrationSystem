class SendBirthdayWishesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.students.where(dob: Date.today).each do |user|
      UserMailer.with(user: user).happy_birthday.deliver_now
    end
  end
end
