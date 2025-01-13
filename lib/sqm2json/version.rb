module Sqm2Json
  VERSION = '0.0.5'

  def self.get_supported_versions
    [12, 51, 52, 54]
  end

  def self.version_supported?(version)
    get_supported_versions.include?(version)
  end

end
