require 'aws-sdk-ecr'
require 'json'
require_relative 'profile'

class Policy
    def ask
	printf "Repository Name: "
	@repo_name = STDIN.gets.chomp
    end

    def get_policy
	c = Login.new
	ecr = Aws::ECR::Client.new(region: 'us-east-1', credentials: c.get_credentials)

	ask

	repo_policy = ecr.get_repository_policy({
	    repository_name: "#{@repo_name}"
	})

	policy = repo_policy.policy_text
	parsed_policy = JSON.parse(policy)

	parsed_policy['Statement'].each do |st|
	    puts "= Allowed actions for: " + st['Sid']
	    st['Action'].each do |a|
		puts "\t- " + a
	    end
	    puts " "
	end

    end
end

Policy.new.get_policy
