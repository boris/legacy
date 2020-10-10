require 'aws-sdk'
require_relative 'profile'

class User
    def create
	c = Login.new

	username = ARGV[0]

	iam = Aws::IAM::Client.new(region: "#{ENV['region']}", credentials: c.get_credentials)

	begin
	    user = iam.create_user(user_name: username)
	    iam.wait_until(:user_exists, user_name: username)
	    puts "New user '#{username}' created"

	rescue Aws::IAM::Errors::EntityAlreadyExists
	    puts "User '#{username}' already exists!"
	end
    end
end
User.new.create
