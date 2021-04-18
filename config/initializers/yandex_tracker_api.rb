YandexTrackerApi.configure do |config|
  config.domain = "https://api.tracker.yandex.net"
  config.organization_id = "2429022"
  config.access_token = ENV.fetch('YANDEX_TRACKER_ACCESS_TOKEN')
end
