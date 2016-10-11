module Plugins
  module LoomioGroupProgressBar
    class Plugin < Plugins::Base
      setup! :loomio_group_progress_bar do |plugin|
        plugin.enabled = true
        plugin.use_component :group_progress_card, outlet: :before_group_cards
        plugin.use_translations 'config/locales', :group_progress_card
      end
    end
  end
end
