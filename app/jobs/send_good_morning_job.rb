class SendGoodMorningJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    User.students.find_each do |user|
      UserMailer.with(user: user).good_morning.deliver_now
    end
  end
end
