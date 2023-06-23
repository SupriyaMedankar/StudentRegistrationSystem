task :birthday_wish do
    SendBirthdayWishesJob.perform_in(1.minute)

    puts 'Birthday messages sent'
end