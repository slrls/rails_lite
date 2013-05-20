class Route
  attr_reader :pattern

  def initialize(pattern, method, controller_class, action_name)
    @pattern = pattern
    @method = method
    @controller_class = controller_class
    @action_name = action_name
  end

  def matches?(req)
    req.path =~ @pattern && req.request_method.downcase.to_sym == @method.downcase.to_sym
  end

  def run(req, res)
    @controller_class.new(req, res).invoke_action(@action_name)
  end
end