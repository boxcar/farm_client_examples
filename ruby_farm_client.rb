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
require 'digest/md5'

SETTINGS = { 
  :email    => 'EXAMPLE',
  :password => 'EXAMPLE'
}

EventMachine.run {
  http = EventMachine::HttpRequest.new("ws://farm.boxcar.io:8080/websocket").get :timeout => 0
 
  http.errback {
    puts "There was a problem maintaining the connection."
  }

  http.callback {
    puts "Connected!  Send yourself a notification.  Find example code at http://github.com/boxcar"
    http.send "{\"app_name\":\"FARM Example\",
                \"username\":\"#{SETTINGS[:email]}\",
                \"password\":\"#{Digest::MD5.hexdigest(SETTINGS[:password])}\",
                \"app_ver\":\"1.0\"}"
  }

  http.stream { |msg|
    puts "Recieved: #{msg}"
  }
}