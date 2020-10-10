require 'aws-sdk-iam'
require_relative 'profile'

class Password
    def change
	c = Login.new

	username = ARGV[0]
	old_pass = ARGV[1]
	new_pass = ARGV[2]

	iam = Aws::IAM::Client.new(region: "#{ENV['region']}", credentials: c.get_credentials)

	iam.change_password({
	    old_password: "#{old_pass}",
	    new_password: "#{new_pass}"
	})

    end
end
