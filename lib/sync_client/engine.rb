module SyncClient
  class Engine < ::Rails::Engine

    initializer "sync_client.eager_load", after: :set_autoload_paths do |app|
      eager_load_sync_client if threadsafe?(app.config)
    end

    def eager_load_sync_client
      paths["app/models"].each do |load_path|
        matcher = /\A#{Regexp.escape(load_path)}\/(.*)\.rb\Z/
        Dir.glob("#{load_path}/**/*.rb").sort.each do |file|
          require_dependency file.sub(matcher, '\1')
        end
      end
    end

    def threadsafe?(app_config)
        app_config.cache_classes ||
        !app_config.dependency_loading ||
        app_config.allow_concurrency
    end
  end
end
