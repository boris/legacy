require 'aws-sdk-ecr'
require_relative 'profile'

class Repo
    def ask
	printf "Repository Name: "
	@repo_name = STDIN.gets.chomp
    end

    def create
	c = Login.new
	ecr = Aws::ECR::Client.new(region: "#{ENV['region']}", credentials: c.get_credentials)

	ask

	repo = ecr.create_repository({
	    repository_name: "#{@repo_name}"
	})

	puts "Repository Details: #{repo.repository.repository_uri}"

    end
end

Repo.new.create
