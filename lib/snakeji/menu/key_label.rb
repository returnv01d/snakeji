class KeyLabel
  def initialize(bounding_box, label_content, key_content)
    @bounding_box = bounding_box
    @label_content = label_content
    @key_content = key
    create_label_text
    create_key_text
  end

  def create_label_text
    @label = Text.new()
  end
end