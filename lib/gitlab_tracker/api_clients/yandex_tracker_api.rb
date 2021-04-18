module YandexTrackerApi
  extend Dry::Configurable

  setting :domain, reader: true
  setting :access_token, reader: true
  setting :organization_id, reader: true

  def self.root_path
    "#{domain}/v2"
  end
end
