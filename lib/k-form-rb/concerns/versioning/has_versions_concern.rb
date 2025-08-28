module KFormRb
  module Concerns
    module Versioning
      module HasVersionsConcern
        extend ActiveSupport::Concern

        # Evaluate given block in context of base class, so that
        # you can write class macros here.
        included do |base|
          before_save :set_version
          after_save :versionize
          after_destroy :versionize_deletion
        end

        # Define class methods from given block.
        # You can define private class methods as well.
        class_methods do

          def version_klass
            reflections['versions'].klass
          end

        end

        # Add instance methods (including actions) below this line.
        # You can define private instance methods as well.
        def set_version
          self.version = new_record? ? 1 : self.version + 1
        end

        def version_klass
          self.class.version_klass
        end

        def versionize
          version_attributes = self.attributes
          version_instance = self.version_klass.new

          _id = version_attributes.delete('id')

          created_at = version_attributes.delete('created_at')
          updated_at = version_attributes.delete('updated_at')
          created_by_id = version_attributes.delete('created_by_id')
          updated_by_id = version_attributes.delete('updated_by_id')

          if version_instance.respond_to?('original_created_at')
            version_attributes['original_created_at'] = created_at
          end

          if version_instance.respond_to?('original_updated_at')
            version_attributes['original_updated_at'] = updated_at
          end

          if version_instance.respond_to?('original_deleted_at')
            version_attributes['original_deleted_at'] = nil
          end

          if version_instance.respond_to?('original_created_by_id')
            version_attributes['original_created_by_id'] = created_by_id
          end

          if version_instance.respond_to?('original_updated_by_id')
            version_attributes['original_updated_by_id'] = updated_by_id
          end

          if version_instance.respond_to?('original_deleted_by_id')
            version_attributes['original_deleted_by_id'] = nil
          end

          self.versions.create!(version_attributes)
        end

        def versionize_deletion
          now = Time.now
          current_user = Current.user
          version_attributes = self.attributes
          version_instance = self.version_klass.new

          id = version_attributes.delete('id')
          created_at = version_attributes.delete('created_at')
          _updated_at = version_attributes.delete('updated_at')
          created_by_id = version_attributes.delete('created_by_id')
          _updated_by_id = version_attributes.delete('updated_by_id')

          if version_instance.respond_to?('original_created_at')
            version_attributes['original_created_at'] = created_at
          end

          if version_instance.respond_to?('original_updated_at')
            version_attributes['original_updated_at'] = now
          end

          if version_instance.respond_to?('original_deleted_at')
            version_attributes['original_deleted_at'] = now
          end


          if version_instance.respond_to?('original_created_by_id')
            version_attributes['original_created_by_id'] = created_by_id
          end

          if version_instance.respond_to?('original_updated_by_id')
            version_attributes['original_updated_by_id'] = current_user.try(:id)
          end

          if version_instance.respond_to?('original_deleted_by_id')
            version_attributes['original_deleted_by_id'] =  current_user.try(:id)
          end


          version_attributes['fk_original_id'] = id
          version_attributes['version'] += 1

          version_klass.create!(version_attributes)
        end
      end
    end
  end
end