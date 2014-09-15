# Load the Rails application.
require File.expand_path('../application', __FILE__)
CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]

# Initialize the Rails application.
Rails.application.initialize!
