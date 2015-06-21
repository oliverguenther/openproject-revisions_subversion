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

        def scm
          @scm ||= scm_adapter.new(local_svn_url, local_svn_url,
                                   login, password, path_encoding)
          update_attribute(:root_url, @scm.root_url) if root_url.blank?
          @scm
        end

        def local_svn_url
          "file://#{svn_repo_path}"
        end

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
