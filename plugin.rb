module Plugins
  module LoomioGroupProgressBar
    class Plugin < Plugins::Base
      setup! :loomio_group_progress_card do |plugin|
        plugin.enabled = true
        plugin.use_component :group_progress_card, outlet: :before_group_column_right
        plugin.use_translations 'config/locales', :group_progress_card

        plugin.use_test_route(:setup_progress_card) do
          veronica = User.create!(name: 'Veronica Sawyers',
                                  email: 'veronicasawyers@example.com',
                                  username: 'veronicasawyers',
                                  password: 'passwordpassword',
                                  angular_ui_enabled: true).tap {|u| u.experienced! 'welcomeModal'}
          group = Group.new(name: 'New group')
          GroupService.create(group: group, actor: veronica)
          group.update_attribute(:enable_experiments, true)
          group.add_admin! veronica
          sign_in veronica
          redirect_to group_path(group)
        end
      end
    end
  end
end
