# Templates configuration should define path relative to rails root and name of template
TEMPLATES_CONFIG = YAML.load(File.open(Rails.root.join('config', 'templates.yml')))[Rails.env]
# Populate application config and update asset pipeline to use template
Rails.application.config.templates = OpenStruct.new(TEMPLATES_CONFIG)
Rails.application.config.templates.path = Rails.root.join(Rails.application.config.templates.path, Rails.application.config.templates.name)
Rails.application.config.assets.paths << Rails.application.config.templates.path.join('assets')