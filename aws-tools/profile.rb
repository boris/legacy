require 'aws-sdk'

class Login
    def get_credentials
	creds = Aws::SharedCredentials.new(profile_name: "default", region: "#{ENV['region']}")
    end
end
