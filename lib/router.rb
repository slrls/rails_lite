require './route.rb'

class Router
  VERBS = ["get", "post", "put", "delete"]

  VERBS.each do |verb|
    define_method(verb) do |pattern, controller_class, action_name|
      add_routes(pattern, verb, controller_class, action_name)
    end
  end

  def initialize(req, res)
    @routes = []
    @req = req
    @res = res
  end

  def add_routes(pattern, verb, controller_class, action_name)
    @routes << Route.new(pattern, verb, controller_class, action_name)
  end

  def match
    @routes.find do |route|
      @req.path =~ route.pattern
    end
  end

  def draw(&blk)
    self.instance_eval(&blk)
  end

  def run
    route = match
    route.nil? ? @res.status = "404" : route.run(@req, @res)
  end
end