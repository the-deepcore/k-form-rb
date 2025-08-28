module KFormRb
  module Concerns
    module Versioning
      module VersionsConcern
        extend ActiveSupport::Concern

        # Evaluate given block in context of base class, so that
        # you can write class macros here.
        included do |base|
        end

        # Define class methods from given block.
        # You can define private class methods as well.
        class_methods do
          def before(version:, sort_key: :version)
            where(
              arel_table[:fk_original_id].eq(version.fk_original_id).and(
                arel_table[sort_key].lt(version.send(sort_key))
              )
            ).order(arel_table[sort_key].desc).
              first
          end

          def after(version:, sort_key: :version)
            where(
              arel_table[:fk_original_id].eq(version.fk_original_id).and(
                arel_table[sort_key].gt(version.send(sort_key))
              )
            ).order(arel_table[sort_key].asc).
              first
          end

          def most_recent_at(time)
            most_recents = arel_table

            subquery = arel_table.project(
              most_recents[:fk_original_id], most_recents[:original_updated_at].maximum.as("most_recent")
            ).where(arel_table[:original_updated_at].lteq(time))
                                 .group(most_recents[:fk_original_id]).as("most_recents")

            join = arel_table.join(subquery).on(
              arel_table[:fk_original_id].eq(subquery[:fk_original_id]).and(
                arel_table[:original_updated_at].eq(subquery[:most_recent])
              )
            ).join_sources

            result = joins(join).where(arel_table[:original_deleted_at].eq(nil))

            result
          end

          def most_recent(sort_key: :version)
            order(arel_table[sort_key].desc).first
          end

          def least_recent(sort_key: :version)
            order(arel_table[sort_key].asc).first
          end

          def compare(previous_version: nil , current_version:)
            # return a hash with all the differences
            previous_attributes = previous_version.try(:attributes) || {}
            current_attributes = current_version.attributes

            result = {}

            current_attributes.each do |attribute_name, current_value|
              previous_value =  previous_attributes[attribute_name]

              if current_value != previous_value
                result[attribute_name] = {
                  previous: previous_value,
                  current:current_value
                }
              end
            end

            result
          end
        end

        # Add instance methods (including actions) below this line.
        # You can define private instance methods as well.
        def previous
          self.class.before(version: self)
        end

        def next
          self.class.after(version: self)
        end

        def compare_with(previous_version)
          self.class.compare(previous_version: previous_version, current_version: self)
        end
      end
    end
  end
end