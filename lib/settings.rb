module Settings
  def self.load_settings
    @@settings = YAML::load_file(Rails.root+'config/settings.yml').with_indifferent_access
  end
  def self.[](index)
    load_settings unless defined? @@settings
    @@settings[index]
  end
  def self.[]=(index,value)
    load_settings unless defined? @@settings
    @@settings[index] = value
  end
end

