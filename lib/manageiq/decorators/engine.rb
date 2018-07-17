module ManageIQ
  module Decorators
    class Engine < ::Rails::Engine
      config.autoload_paths << root.join('lib').to_s
      config.assets.paths << root.join('app', 'assets', 'images').to_s

      def vmdb_plugin?
        true
      end
    end
  end
end
