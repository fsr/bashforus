set :branch, 'develop'

set :bundle_without, 'development test'
set :puma_env, fetch(:stage)
set :puma_threads, [2, 2]
set :puma_workers, 2

server 'beta.fsrbash.de', user: fetch(:application), roles: %w{web app db}