require 'aws-sdk-ec2'
require_relative 'profile'

class SecurityGroups
    def get_sg
	c = Login.new
	ec2 = Aws::EC2::Client.new(region: '"#{ENV[region]}"', credentials: c.get_credentials)

	ec2.describe_security_groups.security_groups.each do |security_group|
	    exec "terraform import aws_security_group.#{security_group.group_name} #{security_group.group_id}"
	end
    end
end

SecurityGroups.new.get_sg 
