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
          ['file://', svn_repo_path].join
        end

        # Returns the repository name
        #
        # e.g., Project Foo, Subproject Bar => 'foo/bar'
        def svn_repository_name
          if (parent_path = get_full_parent_path).empty?
            project.identifier
          else
            File.join(parent_path, project.identifier)
          end
        end

        def get_full_parent_path
          parent_parts = []
          p = project
          while p.parent
            parent_id = p.parent.identifier.to_s
            parent_parts.unshift(parent_id)
            p = p.parent
          end

          return parent_parts.join("/")
        end

      end

    end
  end
end
Repository::Subversion.send(:include, OpenProject::Revisions::Subversion::Patches::RepositorySubversionPatch)
