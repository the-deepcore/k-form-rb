module KFormRb
  module CalculatedFields
    module CoreConcern
      extend ActiveSupport::Concern

      included do |base|
        attr_accessor :disable_automatic_calculations
      end

      class_methods do |base|

        def calculate_attribute(name, on: :instance, &block)
          fail ArgumentError unless block_given?
          fail ArgumentError unless [:instance, :collection].include?(on)

          define_instance_methods(name, &block) if on == :instance
          define_collection_methods(name, &block) if on == :collection

        end

        private

        def define_instance_methods(name, &block)
          calculate_method_name = "calculate_#{name}".to_sym
          setter_method_name = "set_#{name}".to_sym
          getter_attribute_name = name.to_sym
          setter_attribute_name = "#{name}=".to_sym


          if self.instance_methods.include?(calculate_method_name)
            raise ArgumentError, "Name conflict! Class #{self} already has an instance method named #{calculate_method_name}!"
          end

          if self.instance_methods.include?(setter_method_name)
            raise ArgumentError, "Name conflict! Class #{self} already has an instance method named #{setter_method_name}!"
          end

          define_method getter_attribute_name do
            unless self.disable_automatic_calculations
              self.public_send(setter_method_name)
            end

            super()
          end

          define_method calculate_method_name do
            self.instance_eval &block
          end

          define_method setter_method_name do
            self.public_send(setter_attribute_name, self.public_send(calculate_method_name) )
          end

        end

        def define_collection_methods(name, &block)

          if self.respond_to?(name)
            raise ArgumentError, "Name conflict! Class #{self} already has a class method named #{name}!"
          end

          define_singleton_method name  do |*attributes|
            collection  = self.where(nil) # hack in order to pass an ActiveRecord::Relation to the block
            collection.instance_exec(*attributes, &block)
          end
        end

      end

    end
  end
end