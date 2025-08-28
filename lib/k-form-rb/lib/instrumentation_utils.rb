module KFormRb
  module Lib
    class InstrumentationUtils
      def self.subscribe(pattern)
        ActiveSupport::Notifications.subscribe(pattern) do |event|
          # event class is ActiveSupport::Notifications::Event
          Rails.logger.debug " ===>  #{event.name} event received, with payload #{event.payload.inspect}!"

          if !Rails.env.test? || ENV['ACTIVATE_INSTRUMENTATION']
            yield(event)
            Rails.logger.debug " ===>  #{event.name} processed !"
          else
            Rails.logger.debug " ===>  #{event.name} ignored !"
          end
        end
      end
    end
  end
end