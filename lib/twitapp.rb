require 'dotenv'
require 'twitter'
require_relative 'handles.rb'

Dotenv.load('.env')


client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end

def tweet_bonjour_monde(handles,client)
  selected_handles = handles.sample(5)?join(" ")
  
  selected_handles.each do |handle|
    client.update("Hello World ! #{handle} @the_hacking_pro #bonjour_monde")
  end
end

def like_bonjour_monde(client)
  tweets = client.search("#bonjour_monde", result_type: "recent").take(25)
  client.favorite(tweets)    
end

def follow_bonjour_monde(client)
  tweets = client.search("#bonjour_monde", result_type: "recent").take(25)
  tweets.each do |tweet|
    client.follow("#{tweet.user.screen_name}")
  end
end
