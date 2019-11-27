require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
    c.before :all do
	c.path = '/sbin:/usr/bin'
    end
end

describe "Apache Daemon" do
    it "escuchando en el puerto 80" do
	expect(port(80)).to be_listening
    end

    it "servicio corriendo" do
	expect(service("apache2")).to be_running
    end
end
