AWS_CONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/aws.yml")).result)[Rails.env]
Aws.config.update({
    :region => AWS_CONFIG['region'],
    :access_key_id => AWS_CONFIG['access_key_id'],
    :secret_access_key => AWS_CONFIG['secret_access_key'],
    :ssl_ca_bundle => AWS_CONFIG['cert'] })