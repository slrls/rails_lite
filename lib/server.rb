require 'webrick'
require './controller_base.rb'

server = WEBrick::HTTPServer.new :Port => 8080
trap('INT') { server.shutdown }

class MyController < ControllerBase
  def go
    if @req.path == "/redirect"
      redirect_to("http://www.google.com")
    elsif @req.path == "/new"
      new_page
    elsif @req.path == "/render"
      render_content(@req.query['content'], "text/text")
    end
  end

  def new_page
    @content = "words words words"
    @title = "title"
    render("new.html.erb")
  end
end

server.mount_proc '/' do |req, res|
  MyController.new(req, res).go
end



server.start