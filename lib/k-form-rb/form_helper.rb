module KFormRb
  module FormHelper
    # There is no easy way to force a custom tag for forms. It would be too much of an hassle to override
    # form_tag_with_body and form_tag_html to support a custom tag and update form_with to call the previous
    # 2 functions with the right arguments.
    #
    # we simply do a low level gsub of ""<form " and "</form>"

    def bs4_vue_form_with(options, &block)
      unless respond_to?(:form_with)
        raise "Your Rails does not implement form_with helper."
      end
      form_tag_name = options.delete(:form_tag_name) || "k-form"

      options[:builder] ||= KFormRb::FormBuilder
      result = if block_given?
                 form_with(**options, &block)
               else
                 form_with(**options)
               end

      if form_tag_name
        result.gsub!("<form ","<#{form_tag_name} " )
        result.gsub!("</form>","</#{form_tag_name}>" )
      end

      result.html_safe
    end
  end
end
