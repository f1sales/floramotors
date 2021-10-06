require "floramotors/version"

require "f1sales_custom/source"
require "f1sales_custom/hooks"
require "f1sales_helpers"

module Floramotors
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    def self.switch_source(lead)

      product_name = lead.product ? lead.product.name : ''
      source_name = lead.source ? lead.source.name : ''

      if product_name.downcase.include?('pcd')
        'PCD'
      elsif product_name.downcase.include?('consorcio')
        'Consorcio'
      elsif product_name.downcase.include?('taxi') || (lead.message || '').downcase.include?('taxi')
        "#{source_name} - Taxista"
      elsif product_name == 'Revisão - Aniversário Honda Flora -2021'
        "#{source_name} - Revisão - Aniversário Honda Flora - 2021"
      elsif product_name == 'Isenções Outubro 2021'
        "#{source_name} - Isenções Outubro 2021"
      else
        lead.source.name
      end
    end
  end
end
