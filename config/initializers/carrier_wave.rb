CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAIB7XBE2XDOQMTSTA',                       # required
      :aws_secret_access_key  => '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',                    # required
    }
    config.fog_directory  = 'myflix'                     # required
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end