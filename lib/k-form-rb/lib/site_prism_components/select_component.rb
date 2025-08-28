module KFormRb
  module Lib
    module SitePrismComponents
      class SelectComponent < SitePrism::Section
        element :select_input, 'select'
        element :error_message, '.input-block__error-feedback'
        element :warning_message, '.input-block__warning-feedback'

        def select(option_text)
          self.select_input.find(:option, option_text).select_option
        end

        def value
          self.select_input.value
        end
      end
    end
  end
end