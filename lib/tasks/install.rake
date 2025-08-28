require "thor"

class Hammer < Thor
  include Thor::Actions
end

namespace :k_form_rb do
  desc "Install KForms in this application"
  task :install do
    Hammer.source_root "#{__dir__}/"

    hammer.insert_into_file 'app/helpers/application_helper.rb', after: "module ApplicationHelper\n" do
      <<~HELPER

          def default_form_builder
            ApplicationFormBuilder
          end

          def original_form_builder
            ActionView::Helpers::FormBuilder
          end
      HELPER
    end

    hammer.copy_file "examples/vuejs_forms_controller.js", "app/javascript/controllers/vuejs_forms_controller.js"
    hammer.copy_file "examples/application_form_builder.rb", "app/models/application_form_builder.rb"
    hammer.empty_directory "app/javascript/forms"
    hammer.empty_directory "app/javascript/forms/components"
    hammer.copy_file "examples/.keep", "app/javascript/forms/components/.keep"
    hammer.empty_directory "app/javascript/forms/plugins"
    hammer.copy_file "examples/.keep", "app/javascript/forms/plugins/.keep"
    hammer.run "yarn add git+https://github.com/kundigo/k-form-js.git#master"
  end

  private

  def hammer
    @hammer ||= Hammer.new
  end
end