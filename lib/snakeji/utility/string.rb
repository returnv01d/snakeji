
class String
  def numeric?
    return true if self =~ /\A\d+\Z/
    true if Float(self) rescue false
  end

  # taken from Rails ActiveSupport::Inflector
  def underscore
    word = self.dup
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end
end
