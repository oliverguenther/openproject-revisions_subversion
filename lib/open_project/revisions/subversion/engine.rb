module OpenProject::Revisions::Subversion

  def self.logger
    Rails.logger
  end

  class Engine < ::Rails::Engine
    engine_name :openproject_revisions_subversion


    def self.default_hostname
      Socket.gethostname || 'localhost'
    rescue
      nil
    end


    def self.settings
      { :partial => 'settings/openproject_revisions_subversion',
        :default => {
          :svnadmin => 'svnadmin',
          :svn_url_hostname => default_hostname,
          :svn_url_path => '/svn',
          :repositories_root => File.join(Dir.home, 'repositories', 'svn').to_s,
        }
      }
    end

    include OpenProject::Plugins::ActsAsOpEngine

    register 'openproject-revisions_subversion',
      :author_url => 'https://github.com/oliverguenther/openproject-revisions_subversion',
      :requires_openproject => '>= 3.0.0',
      :settings => settings

    config.to_prepare do

      # act_as_op_engine doesn't like the hierarchical plugin/engine name :)
      [ :repositories_helper, :repository_subversion ].each do |sym|
        require_dependency "open_project/revisions/subversion/patches/#{sym}_patch"
      end
    end

    initializer 'revisions_subversion.hooks' do
      require 'open_project/revisions/subversion/hooks'
      OpenProject::Revisions::ProxiedRepositoryHook.delegate(Hooks::RepoCreatorHook)
    end

  end
end
