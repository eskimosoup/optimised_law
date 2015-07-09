defaults = {
  'Maintainer' => '@eskimosoup.co.uk',
  'Error Report Level' => "1"
}

SITE_SETTINGS = YAML.load_file(File.join(Rails.root, 'config', 'site_settings', "#{Rails.env}.yml")).merge(defaults)
