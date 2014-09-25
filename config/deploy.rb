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

namespace :solr do
  desc "start solr"
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake sunspot:solr:start"
  end

  desc "stop solr"
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake sunspot:solr:stop"
  end

  desc "reindex the whole database"
  task :reindex, :roles => :app do
    stop
    run "rm -rf #{shared_path}/solr/data/*"
    start
    puts "You need to run this yourself now:"
    puts "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake sunspot:solr:reindex"
  end

  desc "Symlink in-progress deployment to a shared Solr index"
  task :symlink, :except => { :no_release => true } do
    run "ln -s #{shared_path}/solr/data/ #{release_path}/solr/data"
    run "ln -s #{shared_path}/solr/pids/ #{release_path}/solr/pids"
  end
end

after "deploy:update_code", "solr:symlink"