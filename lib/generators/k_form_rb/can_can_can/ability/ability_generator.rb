module KFormRb
    module CanCanCan
      class AbilityGenerator < Rails::Generators::Base
        desc "Inits the cancancan ability file"
        source_root File.expand_path("templates", __dir__)


        def add_ability_configuration
          say "Copying ability.rb to app/abilities", :green
          template("ability.rb", "app/abilities/ability.rb")
        end
      end
    end
  end