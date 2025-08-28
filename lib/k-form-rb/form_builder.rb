module KFormRb
  class FormBuilder < ActionView::Helpers::FormBuilder

    alias_method :original_check_box, :check_box
    alias_method :original_date_field, :date_field
    alias_method :original_datetime_field, :datetime_field
    alias_method :original_time_field, :time_field
    alias_method :original_hidden_field, :hidden_field
    alias_method :original_label, :label
    alias_method :original_number_field, :number_field
    alias_method :original_select, :select
    alias_method :original_submit, :submit
    alias_method :original_text_area, :text_area
    alias_method :original_text_field, :text_field

    def autocomplete(attribute, choices = nil, options = {}, html_options = {}, &block)
      result = original_select(attribute, choices, options, html_options, &block)
      result.gsub!('<select ', '<k-autocomplete ')
      result.gsub!('</select>', '></k-autocomplete>')

      result.html_safe
    end

    def check_box(attribute, options = {}, checked_value = "1", unchecked_value = "0")
      result = original_check_box(attribute, options, checked_value, unchecked_value)
      result.gsub!(/<input[^<]*hidden[^<]*\/>/, '') # remove hiden field (it will be created again in vue JS)
      result.gsub!('<input ', '<k-check_box ')
      result.gsub!('/>', "  checked_value=\"#{checked_value}\" unchecked_value=\"#{unchecked_value}\"></k-check_box>")
      result.gsub!(/ value="\w+"/, '') # convention : the checked value property is named check_value instead of value
      result.html_safe
    end

    def date_field_old(attribute, options = {})
      result = original_text_field(attribute, options)
      result.gsub!('<input ', '<k-date-old ')
      result.gsub!('/>', '></k-date-old>')

      result.html_safe
    end

    def date_field(attribute, options = {})
      result = original_text_field(attribute, options)
      result.gsub!('<input ', '<k-date ')
      result.gsub!('/>', '></k-date>')

      result.html_safe
    end

    def datetime_field_old(attribute, options = {})
      result = original_text_field(attribute, options)
      result.gsub!('<input ', '<k-datetime-old ')
      result.gsub!('/>', '></k-datetime-old>')

      result.html_safe
    end

    def multi_check(attribute, options = {})
      result = original_text_field(attribute, options)
      result.gsub!('<input ', '<k-multi-check ')
      result.gsub!('/>', '></k-multi-check>')

      result.html_safe
    end

    def datetime_field(attribute, options = {})
      result = original_text_field(attribute, options)
      result.gsub!('<input ', '<k-datetime ')
      result.gsub!('/>', '></k-datetime>')

      result.html_safe
    end

    def hidden_field(attribute, options = {})
      result = original_hidden_field(attribute, options)
      result.gsub!('<input ', '<k-hidden ')
      result.gsub!('/>', '></k-hidden>')

      result.html_safe
    end

    def label(attribute, text = nil, options = {}, &block)

      result = original_label(attribute, text, options, &block)
      result.gsub!('<label ', '<k-label ')
      result.gsub!('</label>', '</k-label>')

      result.html_safe
    end

    def number_field(attribute, options = {})
      result = original_number_field(attribute, options)
      result.gsub!('<input ', '<k-input ')
      result.gsub!('/>', '></k-input>')

      result.html_safe
    end

    def select(attribute, choices = nil, options = {}, html_options = {}, &block)
      result = original_select(attribute, choices, options, html_options, &block)
      result.gsub!('<select ', '<k-select ')
      result.gsub!('/>', '></k-select>')

      result.html_safe
    end

    def submit(value = nil, options = {})
      result = original_submit(value, options)
      result.gsub!('<input ', '<k-submit ')
      result.gsub!('/>', '></k-submit>')

      result.html_safe
    end

    def text_area(attribute, options = {})
      result = original_text_area(attribute, options)
      result.gsub!('<textarea ', '<k-textarea ')
      result.gsub!('/>', '></k-textarea>')

      result.html_safe
    end

    def text_field(attribute, options = {})
      result = original_text_field(attribute, options)
      result.gsub!('<input ', '<k-input ')
      result.gsub!('/>', '></k-input>')

      result.html_safe
    end

    def monaco_editor(attribute, options = {})
      result = original_text_area(attribute, options)
      result.gsub!('<textarea ', '<k-monaco_editor ')
      result.gsub!('/>', '></k-monaco_editor>')

      result.html_safe
    end

    def quill_editor(attribute, options = {})
      result = original_text_area(attribute, options)
      result.gsub!('<textarea ', '<k-quill_editor ')
      result.gsub!('/>', '></k-quill_editor>')

      result.html_safe
    end

    def toggle(attribute, options = {})
      result = original_text_field(attribute, options)
      result.gsub!('<input ', '<k-toggle-switch ')
      result.gsub!('/>', '></k-toggle-switch>')

      result.html_safe
    end

    def tel_input(attribute, options = {})
      result = original_text_field(attribute, options)
      result.gsub!('<input ', '<k-tel-input ')
      result.gsub!('/>', '></k-tel-input>')
      result.html_safe
    end

    # no-rspec
    def tag_name(method)
      "#{@object_name}[#{method}]"
    end

    def time_field(attribute, options = {})
      result = original_text_field(attribute, options)
      result.gsub!('<input ', '<k-time ')
      result.gsub!('/>', '></k-time>')

      result.html_safe
    end

    # no-rspec
    def tag_id(method)
      @template.send(:sanitize_to_id, tag_name(method))
    end
  end
end
