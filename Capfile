require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
require 'capistrano/puma/workers'
require 'capistrano/puma/jungle'
require 'capistrano/puma/monit'
require 'whenever/capistrano'
require 'capistrano/team_notifications'

Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }