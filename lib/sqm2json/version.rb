module Sqm2Json
  VERSION = '0.0.4'

  def self.get_supported_versions
    [12,51,52,54]
  end

  def self.is_version_supported?(version)
    get_supported_versions.include?(version)
  end

end
