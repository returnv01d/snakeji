
class String
  def numeric?
    return true if self =~ /\A\d+\Z/
    true if Float(self) rescue false
  end

  # taken from Rails ActiveSupport::Inflector
  def underscore
    self.dup
        .gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        .gsub(/([a-z\d])([A-Z])/,'\1_\2')
        .tr('-', ' ')
        .downcase
  end
end
