require 'bundler/setup'
require 'hanami/setup'
require "hanami/middleware/body_parser"
require "active_support/all"
require_relative '../lib/gitlab_tracker'
require_relative '../apps/api/application'
require_relative './initializers/sidekiq.rb'

Hanami.configure do
  mount Api::Application, at: '/api'

  environment :development do
    # See: https://guides.hanamirb.org/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []
  end
  middleware.use Hanami::Middleware::BodyParser, :json
end
