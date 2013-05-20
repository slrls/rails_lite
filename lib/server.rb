require 'webrick'
require_relative 'controller_base'

server = WEBrick::HTTPServer.new :Port => 8080
trap('INT') { server.shutdown }

class MyController < ControllerBase
  def go
    if @req.path == "/redirect"
      redirect_to("http://www.google.com")
    elsif @req.path =~ /^\/render/
      render_content(@req.query['content'], "text/text")
    end
  end
end

server.mount_proc '/' do |req, res|
  MyController.new(req, res).go
  # res.content_type =
  # res.body = "hi"
  # render_content(res.body, "text/text")
end



server.start