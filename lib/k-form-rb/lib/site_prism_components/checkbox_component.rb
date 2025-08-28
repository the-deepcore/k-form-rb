module KFormRb
  module Lib
    module SitePrismComponents
      class CheckboxComponent < SitePrism::Section
        element :hidden_input, :css, "input[type='hidden']", visible: false
        element :checkbox_input, "input[type='checkbox']"
        element :error_message, '.input-block__error-feedback'
        element :warning_message, '.input-block__warning-feedback'

        def checked(value)
          self.checkbox_input.set(value)
        end
      end
    end
  end
end