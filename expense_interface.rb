require 'active_record'

ActiveRecord::Base.establish_connection(YAML::load(File.open('.db/config.yml'))["development"])
