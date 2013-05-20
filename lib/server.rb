require 'webrick'
require_relative 'controller_base'

server = WEBrick::HTTPServer.new :Port => 8080
trap('INT') { server.shutdown }

class MyController < ControllerBase
  def go
    if req.path = "/redirect"
      redirect_to("www.google.com")
    else
      req.path =~ /^\/render/
    end
  end
end

server.mount_proc '/' do |req, res|
  res.content_type = "text/text"
  res.body = req.path
end



server.start