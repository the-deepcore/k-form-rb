module KFormRb
  module Lib
    module SitePrismComponents
      class DatetimeComponent < SitePrism::Section
        element :text_input, '.input-block__field'
        element :error_message, '.input-block__error-feedback'
        element :warning_message, '.input-block__warning-feedback'

        def fill_in(**options)
          default_options = { fill_options: { clear: :backspace } }
          options.reverse_merge!(default_options)

          self.text_input.fill_in(**options)
        end

        def value
          self.text_input.value
        end
      end
    end
  end
end