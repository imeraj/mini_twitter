require 'pusher'

Pusher.app_id = '305970'
Pusher.key = ENV["PUSHER_KEY"]
Pusher.secret = ENV["PUSHER_SECRET"]
Pusher.cluster = "mt1"
Pusher.logger = Rails.logger
Pusher.encrypted = true
