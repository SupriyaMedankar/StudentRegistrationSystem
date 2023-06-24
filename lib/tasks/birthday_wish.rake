task birthday_wish: :environment do
    SendBirthdayWishesJob.perform_now

    puts 'Birthday messages sent'
end