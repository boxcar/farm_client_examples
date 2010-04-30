# MIT Licensed
# Author: Boxcar, http://boxcar.io
# 
# requires: em-http-request, em-websocket gems.
#
# Be sure to modify the SETTINGS hash and replace it with your Boxcar email and password.

require 'rubygems'
require 'eventmachine'
require 'em-http'
require 'em-websocket'

SETTINGS = { 
  :email    => 'example@example.com',
  :password => 'example'
}

EventMachine.run {
  http = EventMachine::HttpRequest.new("ws://localhost:8080/websocket").get :timeout => 0
 
  http.errback {
    puts "There was a problem maintaining the connection."
  }

  http.callback {
    puts "Connected!  Send yourself a notification.  Find example code at http://github.com/boxcar"
    http.send "{\"action\":\"login\",\"email\":\"#{SETTINGS[:email]}\",\"password\":\"#{SETTINGS[:password]}\"}"
  }

  http.stream { |msg|
    puts "Recieved: #{msg}"
  }
}