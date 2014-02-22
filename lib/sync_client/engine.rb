module SyncClient
  class Engine < ::Rails::Engine
    initializer "sync_client.eager_load", after: :set_autoload_paths do |app|
      paths["app/models"].each do |load_path|
        matcher = /\A#{Regexp.escape(load_path)}\/(.*)\.rb\Z/
        Dir.glob("#{load_path}/**/*.rb").sort.each do |file|
          require_dependency file.sub(matcher, '\1')
        end
      end
    end
  end
end
