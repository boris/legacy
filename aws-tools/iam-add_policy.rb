require 'aws-sdk-iam'
require_relative 'profile'

class Policy
    def ask
	printf "Policy Name: "
	@policy_name = STDIN.gets.chomp
	printf "Policy file (json): "
	@policy_document = STDIN.gets.chomp
	printf "Description (optional): "
	@policy_description = STDIN.gets.chomp
    end

    def create
	c = Login.new
	iam = Aws::IAM::Client.new(region: 'us-east-1', credentials: c.get_credentials)

	ask

	# Create new policy
	new_policy = iam.create_policy({
	    policy_name: "#{@policy_name}",
	    policy_document: "#{@policy_document}",
	    description: "#{@policy_description}"
	})

    end
end

Policy.new.create
