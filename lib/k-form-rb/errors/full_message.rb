# inspiration: http://stackoverflow.com/a/4471202/597082
module KFormRb
  module Errors
    module FullMessage
      def full_message(attribute, message, base)
        if message.start_with?('^')
          message[1..-1]
        else
          super
        end
      end
    end
  end
end