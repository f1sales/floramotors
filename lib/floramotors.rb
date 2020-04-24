require "floramotors/version"

require "f1sales_custom/source"
require "f1sales_custom/hooks"
require "f1sales_helpers"

module Floramotors
  class Error < StandardError; end
  class F1SalesCustom::Hooks::Lead 

    def self.switch_source(lead)

      if lead.product.name.downcase.include?('pcd')

        return 'Facebook - PCD'
      elsif lead.product.name.downcase.include?('consorcio')

        return 'Facebook - Consorcio'
      end

      return lead.source.name
    end
  end
end
