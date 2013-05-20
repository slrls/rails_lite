require 'json'
require 'webrick'

class Session
  def initialize(req)
    @req = req
    @cookie_present = @req.cookies.select do |cookie|
      cookie.name == '_rails_lite_app'
    end.first

    @submitted_cookie = WEBrick::Cookie.new('_rails_lite_app', {})
    if @cookie_present
      @submitted_cookie.value = JSON.parse(@cookie_present)
    end
  end

  def [](method)
    self.send(method)
  end

  def []=(method,value)
    self.send("#{method}=", value)
  end

  def store_session(res)
    @new_cookie = WEBrick::Cookie.new('_rails_lite_app', @submitted_cookie.value.to_json)
    # @new_cookie.name =
    # @new_cookie.value =
    res.cookies << @new_cookie
  end
end