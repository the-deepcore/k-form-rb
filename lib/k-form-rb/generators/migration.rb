module KFormRb
  module Generators
    module Migration
      # override the next_migration_number so that we can have
      # timestamps including microseconds
      def next_migration_number(number)
        if ActiveRecord::Base.timestamped_migrations
          # use timestamps with micro seconds
          [Time.now.utc.strftime("%Y%m%d%H%M%S%6N"), "%.20d" % number].max
        else
          super
        end
      end
    end
  end
end

