set :branch, 'develop'

set :bundle_without, 'development test'
set :puma_env, fetch(:stage)
set :puma_threads, [2, 2]
set :puma_workers, 2

server 'beta.fsrbash.de', user: fetch(:application), roles: %w{web app db}

namespace :deploy do
  task :setup_solr_data_dir do
  	on roles :app do
	  within shared_path do
	    execute :mkdir, "-p solr || true"
	  end
	end
  end
end
 
namespace :solr do
  desc "start solr"
  task :start do 
  	on roles :app do
	  within fetch(:release_path) do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec sunspot-solr start"
        end
      end
	end
  end
  desc "stop solr"
  task :stop do 
  	on roles :app do
	  within fetch(:release_path) do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec sunspot-solr stop || true" 
        end
      end
    end
  end
  desc "reindex the whole database"
  task :reindex do
   	on roles :app do
   	  invoke 'solr:stop'
   	  invoke 'solr:start'
	  within fetch(:release_path) do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec rake sunspot:solr:reindex"
        end
      end
    end
  end
end
 
after 'deploy:starting', 'deploy:setup_solr_data_dir'
after 'deploy:published', 'solr:reindex'