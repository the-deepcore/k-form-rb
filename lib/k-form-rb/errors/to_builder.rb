# inspiration: http://stackoverflow.com/a/4471202/597082
module KFormRb
  module Errors
    module ToBuilder
      def to_builder
        Jbuilder.new do |json|
          json._is_valid self.empty?
          self.attribute_names.each do |attribute|
            json.set! attribute, self.full_messages_for(attribute).first
          end
        end
      end
    end
  end
end