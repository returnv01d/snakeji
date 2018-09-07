require_relative '../Base/elements_controller'

class EmojiiPanelsController < ElementsController

  def initialize
    super()
  end

  def <<(emojii_panel)
    emojii_panel.add_observer(self, :on_emojii_click)
    @emojii_panels << emojii_panel
  end

  def on_emojii_click (emojii_panel, emojii_pos)
    other_emojii_panels = @emojii_panels - [emojii_panel]
    # if clicked emojii is selected in other panel - return
    return if selected_in_emojii_panels?(emojii_pos, other_emojii_panels)

    # if in clicked emojii panel there's already selected emojii
    unless emojii_panel.selected_emojii_pos.nil?
      # activate old emojii in other panels
      change_emojii_in_panels(emojii_panel.selected_emojii_pos, @emojii_panels, :activate)
    end
    
    # if user clicked already selected emojii
    if emojii_panel.selected_emojii_pos == emojii_pos
      emojii_panel.selected_emojii_pos = nil # unselect it
    else
      # unselect selected emojii in clicked emojii panel and select new one.
      emojii_panel.selected_emojii_pos = emojii_pos
      # deactivate selected emojii in other panels
      change_emojii_in_panels(emojii_pos, other_emojii_panels, :deactivate)
    end
  end

  def change_emojii_in_panels(emojii_pos, emojii_panels, func)
    emojii_panels.each { |ep| ep.change_emojii_at(emojii_pos, func) }
  end

  def on_keypanel_change(keypanel_is_active, emojii_panel)
    return false if keypanel_is_active || emojii_panel.selected_emojii_pos.nil?

    change_emojii_in_panels(emojii_panel.selected_emojii_pos, @emojii_panels, :activate)
  end

  def selected_in_emojii_panels?(emojii_pos, emojii_panels)
    emojii_panels.any? { |ep| ep.selected_emojii_pos == emojii_pos }
  end
end