require 'aws-sdk'

creds = Aws::SharedCredentials.new(profile_name: 'default')

ec2 = Aws::EC2::Resource.new(region: "#{ENV['region']}", credentials: creds)

ec2.instances.each do |i|
    puts "ID: #{i.id}"
    puts "State: #{i.state.name}"
end

