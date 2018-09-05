require_relative '../Base/elements_controller'

class KeyLabelsController < ElementsController
  def initialize
    super()
  end

  def on_keylabel_click keylabel
    @key_labels -= [keylabel]
    @key_labels.each(&:unselect)
    keylabel.select
    @key_labels << keylabel
  end

  def <<(key_label)
    key_label.add_observer(self, :on_keylabel_click)
    @key_labels << key_label
  end

end