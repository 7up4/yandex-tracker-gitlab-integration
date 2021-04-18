# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in your Gemfile
# require "capistrano/rvm"
require "capistrano/rbenv"
# require "capistrano/chruby"
require "capistrano/bundler"
require "capistrano/hanami/set_hanami_env"
# require "capistrano/rails/assets"
# require "capistrano/rails/migrations"
# require "capistrano/passenger"
require "capistrano/puma"
install_plugin Capistrano::Puma # Default puma tasks
install_plugin Capistrano::Puma::Monit  # if you need the monit tasks

task :use_rbenv do
  require "capistrano/rbenv"
end

task "production" => [:use_rbenv]

require "capistrano/sidekiq"
require "capistrano/sidekiq/monit"

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
