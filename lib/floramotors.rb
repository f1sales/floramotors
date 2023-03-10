require 'floramotors/version'
require 'f1sales_custom/source'
require 'f1sales_custom/hooks'
require 'f1sales_helpers'

module Floramotors
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    def self.switch_source(lead)
      product_name = lead.product&.name ? lead.product.name : ''
      product_name_down = product_name.downcase
      source_name = lead.source ? lead.source.name : ''

      if product_name_down['pcd']
        'PCD'
      elsif product_name_down['consorcio']
        'Consorcio'
      elsif product_name_down['honda new city 84 meses']
        "#{source_name} - Consórcio"
      elsif product_name_down['taxi'] || (lead.message || '').downcase['taxi']
        "#{source_name} - Taxista"
      elsif product_name == 'Revisão - Aniversário Honda Flora -2021'
        "#{source_name} - Revisão - Aniversário Honda Flora - 2021"
      elsif product_name == 'Isenções Outubro 2021'
        "#{source_name} - Isenções Outubro 2021"
      elsif product_name_down['seminovos cooperada']
        "#{source_name} - Heater"
      else
        lead.source.name
      end
    end
  end
end
