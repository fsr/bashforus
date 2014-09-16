set :branch, 'develop'

set :bundle_without, 'development test'
set :puma_env, fetch(:rack_env, fetch(:rails_env, fetch(:application,'staging')))
set :puma_threads, [2, 2]
set :puma_workers, 2

server 'fsrbash.de', user: fetch(:application), roles: %w{web app db}