# Load the Rails application.
require File.expand_path('../application', __FILE__)
CONFIG  = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]
PRIVATE = if File.exists?("#{Rails.root}/config/private.yml")
	YAML.load_file("#{Rails.root}/config/private.yml")[Rails.env]
else
	{}
end

# Initialize the Rails application.
Rails.application.initialize!
