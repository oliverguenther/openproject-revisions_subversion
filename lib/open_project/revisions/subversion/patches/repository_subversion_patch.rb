require_dependency 'repository/subversion'

module OpenProject::Revisions::Subversion
  module Patches
    module RepositorySubversionPatch

      def self.included(base)
        base.class_eval do
          unloadable

          include InstanceMethods

        end
      end

      module InstanceMethods

        def svn_repo_path
          root = Setting.plugin_openproject_revisions_subversion[:repositories_root]
          File.join(File.expand_path(root), svn_repository_name)
        end

        def svn_repo_url
          [
            'https://',
            Setting.plugin_openproject_revisions_subversion[:svn_url_hostname],
            Setting.plugin_openproject_revisions_subversion[:svn_url_path],
            '/',
            svn_repository_name].join
        end

        def svn_repository_name
          project.identifier
        end

      end
    end
  end
end
Repository::Subversion.send(:include, OpenProject::Revisions::Subversion::Patches::RepositorySubversionPatch)
