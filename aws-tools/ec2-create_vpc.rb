require 'aws-sdk-ec2'
require_relative 'profile'

class Vpc

    def ask
	printf "VPC Name: "
    	@vpc_name = STDIN.gets.chomp
    	printf "CIDR Block: "
    	@cidr = STDIN.gets.chomp
    	printf "Public Subnet: "
    	@cidr_pub = STDIN.gets.chomp
	printf "Public AZ: "
	@az_pub = STDIN.gets.chomp
    	printf "Private Subnet: "
    	@cidr_priv = STDIN.gets.chomp
	printf "Private AZ: "
	@az_priv = STDIN.gets.chomp
    end

    def create
	c = Login.new
	ec2 = Aws::EC2::Client.new(region: "#{ENV[region]}", credentials: c.get_credentials)

	ask

	# Create new VPC
	new_vpc = ec2.create_vpc({
	    cidr_block: "#{@cidr}"
	})
	vpc_id = "#{new_vpc.vpc.vpc_id}"

	# Add public and private subnets
	add_pub = ec2.create_subnet({
	    availability_zone: "#{@az_pub}",
	    cidr_block: "#{@cidr_pub}",
	    vpc_id: "#{vpc_id}"
	})

	add_priv = ec2.create_subnet({
	    availability_zone: "#{@az_priv}",
	    cidr_block: "#{@cidr_priv}",
	    vpc_id: "#{vpc_id}"
	})

	# Create and attach Internet GW
	inet_gw = ec2.create_internet_gateway({

	})
	inet_gw_id = "#{inet_gw.internet_gateway.internet_gateway_id}"

	ec2.attach_internet_gateway({
	    internet_gateway_id: "#{inet_gw_id}",
	    vpc_id: "#{vpc_id}"
	})

	# Create Public Route Table
	pub_route_table = ec2.create_route_table({
	    vpc_id: "#{vpc_id}"
	})
	add_pub_rt = ec2.associate_route_table({
	    route_table_id: "#{pub_route_table.route_table.route_table_id}",
	    subnet_id: "#{add_pub.subnet.subnet_id}"
	})
	add_route = ec2.create_route({
	    destination_cidr_block: "0.0.0.0/0",
	    gateway_id: "#{inet_gw_id}",
	    route_table_id: "#{pub_route_table.route_table.route_table_id}"
	})
	
	# Add name to VPC
	new_tag = ec2.create_tags({
	    resources: [
		"#{vpc_id}"
	    ],
	    tags: [{
		key: "Name",
		value: "#{@vpc_name}"
	    }]
	})

	puts "VPC ID: #{vpc_id}"
	puts "VPC Name: #{@vpc_name}"

    end
end

Vpc.new.create
