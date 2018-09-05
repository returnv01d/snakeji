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
    if emojii_panel.has_selected_emojii?
      # activate old emojii it in other panels
      change_emojii_in_panels(emojii_panel.selected_emojii_index, :activate)
    end

    emojii_panel.unselect_each # unselect selected emojii in clicked emojii panel
    emojii_panel.sub_elements[emojii_pos].select # select new emojii
    # deactivate selected emojii in other panels
    other_emojii_panels.each { |ep| ep.change_emojii_at(emojii_pos, :deactivate) }

  end

  def change_emojii_in_panels(emojii_position, func)
    @emojii_panels.each { |ep| ep.change_emojii_at(emojii_position, func) }
  end

  def on_keypanel_change(keypanel_is_active, emojii_panel)
    return false if keypanel_is_active || !emojii_panel.has_selected_emojii?

    change_emojii_in_panels(emojii_panel.selected_emojii_index, :activate)
  end

  def selected_in_emojii_panels?(emojii_pos, emojii_panels)
    emojii_panels.any? { |ep| ep.sub_elements[emojii_pos].selected }
  end
end