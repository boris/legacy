 require 'aws-sdk-ecs'
 require_relative 'profile'

 class Services
     def delete
	 c = Login.new
	 ecs = Aws::ECS::Client.new(region: "#{ENV['region']}", credentials: c.get_credentials)

	 printf "\033[32mCluster\033[0m: "
	 cluster = STDIN.gets.chomp
	 printf "\033[32mService\033[0m: "
	 service = STDIN.gets.chomp

	 printf "\033[31mWARNING\033[0m -  by pressing 'y' you'll remove \033[93m#{service}\033[0m from cluster \033[93m#{cluster}\033[0m.\n\033[31mDo you want to continue?\033[0m (y/n): "
	 prompt = STDIN.gets.chomp

	 if prompt == 'y'
	     service = ecs.delete_service({
		 cluster: "#{cluster}",
		 service: "#{service}"
	     })
	 else
	     puts "mission aborted"
	     return
	 end

     end
 end

 Services.new.delete
