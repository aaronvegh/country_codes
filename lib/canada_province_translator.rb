require 'yaml'

module SunDawg 
  module CanadaProvinceTranslater
    # allows client application to override YAML hash
    FILE = File.expand_path(File.join(File.dirname(__FILE__), 'canada_provinces.yml')) unless defined?(FILE)
    CANADA_PROVINCES = YAML.load_file(FILE) unless defined?(CANADA_PROVINCES)

    # O(N) translation from state name to 2-digit code
    def self.translate_name_to_code(name)
      CANADA_PROVINCES.each_pair do |key, value| 
        return key if value["name"] == name 
      end
      raise NoProvinceError.new("[#{name}] IS NOT VALID")
    end

    # O(1) translation of 2-digit code to name
    def self.translate_code_to_name(code)
      province = CANADA_PROVINCES[code]
      raise NoProvinceError.new("[#{code}] IS NOT VALID") if province.nil?
      province["name"]
    end

    class NoProvinceError < StandardError
    end
  end
end
