task good_moring_wish: :environment do
    SendGoodMorningJob.perform_in(1.minute)

    puts 'Good morning message sent to all'
end