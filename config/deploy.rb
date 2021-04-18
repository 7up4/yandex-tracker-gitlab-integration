# config valid for current version and patch releases of Capistrano
lock "~> 3.11.2"

set :application, "gitlab_tracker"
set :repo_url, "git@gitlab.mhth.ru:nmusayev/issue_tracker.git"
set :ssh_options, forward_agent: true
set :deploy_user, "deploy"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :keep_releases, 5

set :puma_workers, 2

set :sidekiq_config, -> { File.join(current_path, "config", "sidekiq.yml") }

append :linked_files, ".env"

append :linked_dirs,
       "log", "tmp/pids", "tmp/cache", "tmp/sockets",
       "vendor/bundle", "public/system", "public/assets"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

namespace :deploy do
  task :setup_config do
    on roles(:app) do
      execute :mkdir, "-p #{fetch(:deploy_to)}/shared"
      execute :touch, "#{fetch(:deploy_to)}/shared/.env"
    end
  end
end

after "deploy:setup_config", "puma:config"
after "deploy:setup_config", "sidekiq:monit:config"
