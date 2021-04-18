set :hanami_env, "production"
set :full_app_name, "#{fetch(:application)}_#{fetch(:hanami_env)}"
set :sidekiq_env, "#{fetch(:hanami_env)}"

set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:full_app_name)}"
set :sidekiq_require, File.join("#{fetch(:deploy_to)}", "current", "config", "boot.rb")

server "188.246.233.87", user: "deploy", roles: %w{web app db}

append :puma_bind, "tcp://0.0.0.0:4000"

set :rbenv_type, :user
set :rbenv_ruby, "2.7.2"
set :rbenv_map_bins, %w[rake gem bundle ruby hanami sidekiq sidekiqctl pumactl]

namespace :deploy do
  task :update_env do
    on roles(:app) do |_host|
      upload! File.open(".env.production"), "#{fetch(:deploy_to)}/shared/.env"
    end
  end
end
after "deploy:started", "deploy:update_env"
