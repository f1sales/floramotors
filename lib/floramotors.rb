require "floramotors/version"

require "f1sales_custom/source"
require "f1sales_custom/hooks"
require "f1sales_helpers"

module Floramotors
  class Error < StandardError; end
  class F1SalesCustom::Hooks::Lead

    def self.switch_source(lead)

      product_name = lead.product ? lead.product.name : ''
      if product_name.downcase.include?('pcd')
        return 'PCD'
      elsif product_name.downcase.include?('consorcio')

        return 'Consorcio'
      elsif product_name.downcase.include?('taxi') || (lead.message || '').downcase.include?('taxi')
        return "#{lead.source.name} - Taxista"
      elsif product_name == 'Revisão - Aniversário Honda Flora -2021'
          return "#{lead.source.name} - Revisão - Aniversário Honda Flora - 2021"
      end

      return lead.source.name
    end
  end
end
