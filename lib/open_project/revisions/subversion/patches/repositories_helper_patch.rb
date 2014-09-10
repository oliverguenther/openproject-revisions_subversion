module OpenProject::Revisions::Subversion
  module Patches
    module RepositoriesHelperPatch

      def self.included(base)
        base.class_eval do
          unloadable

          include InstanceMethods

          alias_method_chain :subversion_field_tags, :revisions
        end
      end

      module InstanceMethods

        # Add a public_keys tab to the user administration page
        def subversion_field_tags_with_revisions(form,repository)
          render :partial => 'projects/settings/subversion', :locals => { :form => form, :repository => repository }
        end
      end
    end
  end
end

RepositoriesHelper.send(:include, OpenProject::Revisions::Subversion::Patches::RepositoriesHelperPatch)
