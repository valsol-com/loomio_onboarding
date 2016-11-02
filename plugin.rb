module Plugins
  module LoomioOnboarding
    class Plugin < Plugins::Base
      setup! :loomio_onboarding do |plugin|
        plugin.enabled = true
        plugin.use_component :group_progress_card, outlet: [:before_group_page_column_right, :before_thread_page_column_right]
        plugin.use_component :introduction_carousel, outlet: :before_group_page

        plugin.use_translations 'config/locales', :loomio_onboarding

        plugin.use_test_route(:setup_progress_card_coordinator) do
          GroupService.create(group: test_group, actor: patrick)
          test_subgroup = Group.new(name: 'Johnny sub',
                                    parent: test_group,
                                    discussion_privacy_options: 'public_or_private',
                                    group_privacy: 'closed')
          GroupService.create(group: test_subgroup, actor: patrick)
          test_group.update_attribute(:enable_experiments, true)
          test_group.update_attribute(:description, 'Here is a group description')
          test_group.cover_photo = File.new("#{Rails.root}/spec/fixtures/images/strongbad.png")
          test_group.save
          patrick.avatar_kind = 'gravatar'
          patrick.save
          sign_in patrick
          test_discussion
          redirect_to group_url(test_group)
        end
        plugin.use_test_route(:setup_progress_card_member) do
          test_group.update_attribute(:enable_experiments, true)
          sign_in jennifer
          redirect_to group_url(test_group)
        end
        plugin.use_test_route(:setup_group_with_intro_carousel) do
          sign_in emilio
          redirect_to group_url(test_group)
        end
      end
    end
  end
end
