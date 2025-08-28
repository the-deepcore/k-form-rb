module KFormRb
  module Lib
    module SitePrismComponents
      class AutocompleteComponent < SitePrism::Section
        element :text_input, 'input.vs__search'
        element :error_message, 'span.invalid-feedback'

        section :listbox, 'ul.vs__dropdown-menu' do
          elements :text_value, 'li.vs__dropdown-option'
        end

        def selected(**options)
          default_options = { fill_options: { clear: :backspace } }
          options.reverse_merge!(default_options)

          self.text_input.fill_in(**options)
          self.listbox.text_value.first.click
        end

        def value
          self.text_input.value
        end
      end
    end
  end
end