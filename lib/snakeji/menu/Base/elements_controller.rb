class ElementsController
  attr_accessor :container
  def initialize
    class_name = self.class.to_s.chomp('Controller').underscore
    instance_variable_set("@#{class_name}", [])
    self.class.instance_eval("attr_accessor :#{class_name}")
  end

end