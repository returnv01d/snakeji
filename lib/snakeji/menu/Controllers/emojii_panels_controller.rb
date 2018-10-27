require_relative '../Base/elements_controller'

class EmojiiPanelsController < ElementsController

  def initialize
    super()
  end

  def <<(emojii_panel)
    emojii_panel.add_observer(self, :on_emojii_click)
    @emojii_panels << emojii_panel
  end

  def on_emojii_click (emojii_panel, emojii_pos, state)
    other_emojii_panels = @emojii_panels - [emojii_panel]
    case state
      when :emojii_unselected
        change_emojii_in_panels(emojii_pos, other_emojii_panels, :activate)
      when :emojii_selected
        change_emojii_in_panels(emojii_pos, other_emojii_panels, :deactivate)
    end
  end

  def change_emojii_in_panels(emojii_pos, emojii_panels, func)
    emojii_panels.each { |ep| ep.change_emojii_at(emojii_pos, func) }
  end

  def selected_emojiis
    emojiis = []
    active_panels = @emojii_panels.select(&:active)
    active_panels.each{ |ep| emojiis << ep.selected_emojii }
    emojiis
  end

end