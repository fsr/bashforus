lock '3.2.1'
set :application, 'fsrbash'
set :repo_url, 'git@github.com:fsr/bashforus.git'
set :deploy_to, "/home/#{fetch(:application)}/#{fetch(:stage)}"
set :pty, true
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets}
set :linked_files, ['config/private.yml', "db/#{fetch(:stage)}.sqlite3"]
set :bundle_flags, '--deployment'
set :rvm_ruby_version, 'ruby@bashforus'
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_init_active_record, false
set :puma_preload_app, true

set :team_notifications_token, '8244e83a14c8b168b8ab87470671983a'
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do
  after :publishing, :restart
end
