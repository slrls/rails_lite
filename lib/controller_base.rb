require './cookies.rb'
require 'active_support/core_ext'

class ControllerBase
  def initialize(req, res)
    @req = req
    @res = res
    session
  end

  def render_content(content, body_type)
    unless @response_built
      @res.content_type = body_type
      @res.body = content
      @session.store_session(@res)
      @response_built = true
    end
  end

  def redirect_to(url)
    unless @response_built
      @res.status = 302
      @res.header["location"] = url
      @session.store_session(@res)
      @response_built = true
    end
  end

  def session
    @session = Session.new(@req)
  end

  def render(file_name)
    binding
    directory = "#{self.class.name.underscore}".gsub("_controller", "")
    content = ERB.new(File.read("views/#{directory}/#{file_name}")).result(binding)
    render_content(content, "text/html")
  end
end

