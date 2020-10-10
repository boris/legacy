require 'aws-sdk'
require_relative 'profile'

class Key
    def create
	c = Login.new

	username = ARGV[0]

	iam = Aws::IAM::Client.new(region: "#{ENV['region']}", credentials: c.get_credentials)

	begin
	    key_pair = iam.create_access_key({user_name: username})
	    puts "
    Username: \t#{username}
    Access key:\t#{key_pair.access_key.access_key_id}
    Secret key:\t#{key_pair.access_key.secret_access_key}
	    "
	rescue Aws::IAM::Errors::NoSuchEntity
	    puts "User '#{username}' does not exists"
	end
    end
end

Key.new.create
