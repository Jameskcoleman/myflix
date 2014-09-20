CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAIK4U7V67NHWIOSQA',                       # required
      :aws_secret_access_key  => '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',                    # required
    }
    config.fog_directory  = 'myflixjc'                     # required
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end