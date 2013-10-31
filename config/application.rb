require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end


module Huodong
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    # Enable the asset pipeline
    config.assets.enabled = true
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.1'
    
    ActionMailer::Base.delivery_method = :smtp  
    config.action_mailer.perform_deliveries = true  
    config.action_mailer.raise_delivery_errors = true  
    config.action_mailer.default :charset => "utf-8"  
    #smtp
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
        :address              => 'smtp.qq.com',
        :port                 => 25,
        :domain               => 'huodongrili.com',
        :user_name            => 'service@huodongrili.com',
        :password             => 'servic123',
        :authentication       => :login
        }
  end
end
