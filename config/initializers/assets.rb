Rails.application.config.assets.version = "1.0"
Rails.application.config.assets.precompile += %w( lightbox/* admin.css admin.js )
Rails.application.config.assets.paths << Rails.root.join("node_modules")
