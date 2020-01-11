# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w[
  bootstrap-3.4.1.min.css
  fontawesome-5.8.1.min.css
  alertify.min.css
  alertify_bootstrap.min.css
  bootstrap_toggle.min.css
  default.css
]
Rails.application.config.assets.precompile += %w[
  bootstrap-3.4.1.min.js
  jquery.mask-1.14.16.min.js
  alertify.min.js
  ajax.js
]
Rails.application.config.assets.precompile << /\.(?:png|jpg|jpeg|gif)\z/
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/