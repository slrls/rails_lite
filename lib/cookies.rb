require 'json'
require 'webrick'

class Session
  def initialize(req)
    @req = req
    cookie_present = @req.cookies.select do |cookie|
      cookie.name == '_rails_lite_app'
    end.first

    if cookie_present
      @data = JSON.parse(cookie_present.value)
    else
      @data = {}
    end
  end

  def [](method)
    @data[method]
  end

  def []=(method,value)
    @data[method] = value
  end

  def store_session(res)
    @new_cookie = WEBrick::Cookie.new('_rails_lite_app', @data.to_json)
    res.cookies << @new_cookie
  end
end