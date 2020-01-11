require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ceat
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    #
    config.autoload_paths += Dir["#{config.root}/app/models/**/"]
    config.autoload_paths += %W(#{config.root}/lib)


    # config/initializers/locale.rb
    config.i18n.default_locale = 'pt-BR'
    config.i18n.available_locales = :'pt-BR'
    I18n.enforce_available_locales = false
    config.time_zone = 'Brasilia'
    config.active_record.default_timezone = :local
  end
end
