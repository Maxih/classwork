namespace :urlshortener do
  desc "Purge old urls from the urls table"
  task purge_urls: :environment do
    puts "purging old urls"
    ShortenedUrl.prune(10)
  end
end
