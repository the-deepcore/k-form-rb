module KFormRb
  module CalculatedFields
    module CollectionFunctionsConcern
      extend ActiveSupport::Concern


      included do |base|

        calculate_attribute :reduce_sum_prod, on: :collection do |*attributes|
          raise ArgumentError if attributes.blank?

          reduce(0) do |sum, instance|
            product = attributes.reduce(1) { |p, attribute | p * instance.public_send(attribute) }
            sum + product
          end
        end

        calculate_attribute :reduce_sum, on: :collection do |attribute|
          reduce_sum_prod(attribute)
        end

        calculate_attribute :reduce_weighted_average, on: :collection do |averaged_attributes, weight_field|
          reduce_sum_prod(averaged_attributes, weight_field) / reduce_sum(weight_field)
        end
      end
    end
  end
end