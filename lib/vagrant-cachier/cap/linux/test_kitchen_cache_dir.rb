module VagrantPlugins
  module Cachier
    module Cap
      module Linux
        module TestKitchenCacheDir
          def self.test_kitchen_cache_dir(machine)
            '/tmp/test-kitchen/cache'
          end
        end
      end
    end
  end
end
