task good_moring_wish: :environment do
    SendGoodMorningJob.perform_now

    puts 'Good morning message sent to all'
end