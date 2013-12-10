module VagrantPlugins
  module Cachier
    class Bucket
      class TestKitchen < Bucket
        def self.capability
          :test_kitchen_cache_dir
        end

        def install
          machine = @env[:machine]
          guest   = machine.guest

          if guest.capability?(:test_kitchen_cache_dir)
            guest_path = guest.capability(:test_kitchen_cache_dir)

            @env[:cache_dirs] << guest_path

            machine.communicate.tap do |comm|
              comm.execute("mkdir -p /tmp/vagrant-cache/#{@name}")
              unless comm.test("test -L #{guest_path}")
                comm.sudo("rm -rf #{guest_path}")
                comm.sudo("mkdir -p `dirname #{guest_path}`")
                comm.sudo("ln -s /tmp/vagrant-cache/#{@name} #{guest_path}")
              end
            end
          else
            machine.commmunicate.tap do |comm|
              comm.execute("mkdir -p /tmp/vagrant-cache/foo")
            end
            @env[:ui].info I18n.t('vagrant_cachier.skipping_bucket', bucket: 'Test-Kitchen')
          end
        end
      end
    end
  end
end
