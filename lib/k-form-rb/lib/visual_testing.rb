module KFormRb
  module Lib
    module VisualTesting
      extend ::Dry::Configurable
      setting :adapter

      class << self
        def snapshot(page, *args, **kwargs, &block)
          case config.adapter
          when :percy, 'percy'
            page.percy_snapshot(*args, **kwargs, &block)
          when nil, ''
            # no visual testing adapter
          else
            raise "Unknown Visual Testing Adapter #{config.adapter.inspect}"
          end
        end
      end
    end
  end
end