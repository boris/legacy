require 'aws-sdk-ecs'
require_relative 'profile'

class Service
    def bulk_delete
	c = Login.new
	ecs = Aws::ECS::Client.new(region: "#{ENV['region']}", credentials: c.get_credentials)

	# Set vars
	service = ""
	list = Array.new

	# Ask questions
	printf "Cluster: "
	cluster = STDIN.gets.chomp

	printf "\033[93mWhich service do you want to delete? Finish with 'end'\033[0m\n"
	until service == "end"
	    service = STDIN.gets.chomp

	    unless service == "end"
		list.push("#{service}")
	    end
	end

	list.each do |service|
	    printf "\033[32mDeleting #{service} from #{cluster}\033[0m\n"
	    client.delete_service({
	        cluster = "#{cluster}",
	        service = "#{service}"
	    })
	    sleep(2)
	end
    end
end

Service.new.bulk_delete
