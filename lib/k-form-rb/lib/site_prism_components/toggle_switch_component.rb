module KFormRb
  module Lib
    module SitePrismComponents
      class ToggleSwitchComponent < SitePrism::Section
        element :text_input, '.input-toggle-switch__field'
        element :button, '.switch_toggle__slider-button'

        def value
          self.text_input.value
        end
      end
    end
  end
end