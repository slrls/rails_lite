require 'webrick'
require './controller_base.rb'
require './router.rb'

server = WEBrick::HTTPServer.new :Port => 8080
trap('INT') { server.shutdown }

class MyController < ControllerBase
  def go
    if @req.path == "/redirect"
      redirect_to("http://www.google.com")
    elsif @req.path == "/render"
      render_content(@req.query['content'], "text/text")
    end
  end
end

server.mount_proc '/' do |req, res|
  a = Router.new(req, res)

  a.draw do
    get(Regexp.new("^/redirect$"), MyController, :go)
  end
  a.run
  # MyController.new(req, res).go
end

server.start