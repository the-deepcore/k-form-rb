# -*- encoding: utf-8 -*-
# stub: k-form-rb 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "k-form-rb".freeze
  s.version = "0.2.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Dorian LUPU".freeze]
  s.date = "2025-01-08"
  s.description = "This gem provides view helpers & form builders for Rails apps.It should be used in pair with k-form-js private npm package. ".freeze
  s.email = "dorian@kundigo.pro".freeze
  s.files = ["CHANGELOG.md".freeze, "README.md".freeze, "lib/generators".freeze, "lib/generators/k_form_rb".freeze, "lib/generators/k_form_rb/can_can_can".freeze, "lib/generators/k_form_rb/can_can_can/ability".freeze, "lib/generators/k_form_rb/can_can_can/ability/ability_generator.rb".freeze, "lib/generators/k_form_rb/can_can_can/ability/templates".freeze, "lib/generators/k_form_rb/can_can_can/ability/templates/ability.rb".freeze, "lib/k-form-rb".freeze, "lib/k-form-rb.rb".freeze, "lib/k-form-rb/calculated_fields".freeze, "lib/k-form-rb/calculated_fields.rb".freeze, "lib/k-form-rb/calculated_fields/collection_functions_concern.rb".freeze, "lib/k-form-rb/calculated_fields/core_concern.rb".freeze, "lib/k-form-rb/concerns".freeze, "lib/k-form-rb/concerns.rb".freeze, "lib/k-form-rb/concerns/instrumentation_concern.rb".freeze, "lib/k-form-rb/concerns/track_who_made_the_changes_concern.rb".freeze, "lib/k-form-rb/concerns/utils_concern.rb".freeze, "lib/k-form-rb/concerns/validate_without_save_concern.rb".freeze, "lib/k-form-rb/concerns/versioning".freeze, "lib/k-form-rb/concerns/versioning.rb".freeze, "lib/k-form-rb/concerns/versioning/has_versions_concern.rb".freeze, "lib/k-form-rb/concerns/versioning/versions_concern.rb".freeze, "lib/k-form-rb/errors".freeze, "lib/k-form-rb/errors.rb".freeze, "lib/k-form-rb/errors/full_message.rb".freeze, "lib/k-form-rb/errors/to_builder.rb".freeze, "lib/k-form-rb/form_builder.rb".freeze, "lib/k-form-rb/form_helper.rb".freeze, "lib/k-form-rb/generators".freeze, "lib/k-form-rb/generators.rb".freeze, "lib/k-form-rb/generators/migration.rb".freeze, "lib/k-form-rb/lib".freeze, "lib/k-form-rb/lib.rb".freeze, "lib/k-form-rb/lib/bool.rb".freeze, "lib/k-form-rb/lib/full_access_ability.rb".freeze, "lib/k-form-rb/lib/instrumentation_utils.rb".freeze, "lib/k-form-rb/lib/site_prism_components".freeze, "lib/k-form-rb/lib/site_prism_components.rb".freeze, "lib/k-form-rb/lib/site_prism_components/autocomplete_component.rb".freeze, "lib/k-form-rb/lib/site_prism_components/checkbox_component.rb".freeze, "lib/k-form-rb/lib/site_prism_components/date_component.rb".freeze, "lib/k-form-rb/lib/site_prism_components/datetime_component.rb".freeze, "lib/k-form-rb/lib/site_prism_components/quill_editor_component.rb".freeze, "lib/k-form-rb/lib/site_prism_components/select_component.rb".freeze, "lib/k-form-rb/lib/site_prism_components/text_area_component.rb".freeze, "lib/k-form-rb/lib/site_prism_components/text_input_component.rb".freeze, "lib/k-form-rb/lib/site_prism_components/time_component.rb".freeze, "lib/k-form-rb/lib/site_prism_components/toggle_switch_component.rb".freeze, "lib/k-form-rb/lib/visual_testing.rb".freeze, "lib/k-form-rb/railtie.rb".freeze, "lib/k-form-rb/types".freeze, "lib/k-form-rb/types.rb".freeze, "lib/k-form-rb/types/bool_type.rb".freeze, "lib/k-form-rb/warnings".freeze, "lib/k-form-rb/warnings.rb".freeze, "lib/k-form-rb/warnings/validator.rb".freeze, "lib/k-form-rb/warnings/warnings_collection.rb".freeze, "lib/k-form-rb/warnings/warnings_validators_collection.rb".freeze, "lib/tasks/examples".freeze, "lib/tasks/examples/application_form_builder.rb".freeze, "lib/tasks/examples/vuejs_forms_controller.js".freeze, "lib/tasks/install.rake".freeze]
  s.homepage = "https://github.com/kundigo/k-form-rb".freeze
  s.licenses = ["Private code that belongs to KUNDIGO SASU, FRANCE".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.2".freeze)
  s.rubygems_version = "3.5.17".freeze
  s.summary = "A custom Rails form builder using custom tags".freeze

  s.installed_by_version = "3.5.17".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<actionview>.freeze, [">= 5.2".freeze])
  s.add_runtime_dependency(%q<railties>.freeze, [">= 5.2".freeze])
  s.add_runtime_dependency(%q<dry-configurable>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<site_prism>.freeze, [">= 0".freeze])
end
