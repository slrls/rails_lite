require './cookies.rb'

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

end

