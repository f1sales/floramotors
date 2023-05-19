require 'floramotors/version'
require 'f1sales_custom/source'
require 'f1sales_custom/hooks'
require 'f1sales_helpers'

module Floramotors
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    class << self
      def switch_source(lead)
        @lead = lead

        return 'PCD' if product_name_down['pcd']
        return "#{source_name} - Consórcio" if product_name_down['new city 84 meses'] || product_name_down['consorcio']
        return "#{source_name} - Consórcio 2023" if product_name_down['rcio 2023']
        return "#{source_name} - Taxista" if product_name_down['taxi'] || lead_message['taxi']
        return "#{source_name} - Heater" if product_name_down['seminovos cooperada']

        source_name
      end

      def product_name
        @lead.product&.name || ''
      end

      def product_name_down
        product_name.downcase
      end

      def source_name
        @lead.source.name || ''
      end

      def lead_message
        @lead.message&.downcase || ''
      end
    end
  end
end
