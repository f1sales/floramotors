require File.expand_path '../spec_helper.rb', __FILE__
require 'ostruct'
require "f1sales_custom/hooks"

RSpec.describe F1SalesCustom::Hooks::Lead do

  context 'when has some taxi info' do
    let(:source_name) { 'myHonda' }

    context 'when product contains taxi' do

      let(:source) do
        source = OpenStruct.new
        source.name = source_name
        source
      end

      let(:customer) do
        customer = OpenStruct.new
        customer.name = 'Marcio'
        customer.phone = '1198788899'
        customer.email = 'marcio@f1sales.com.br'

        customer
      end

      let(:product) do
        product = OpenStruct.new
        product.name = 'Taxista -'

        product
      end

      let(:lead) do
        lead = OpenStruct.new
        lead.message = 'como_deseja_ser_contatado?: e-mail: escolha_a_unidade_savol_kia: savol_kia_santo_andré'
        lead.source = source
        lead.customer = customer
        lead.product = product

        lead
      end

      it 'returns source name' do
        expect(described_class.switch_source(lead)).to eq('myHonda - Taxista')
      end
    end

    context 'when message contains taxi' do
      let(:source) do
        source = OpenStruct.new
        source.name = source_name
        source
      end

      let(:customer) do
        customer = OpenStruct.new
        customer.name = 'Marcio'
        customer.phone = '1198788899'
        customer.email = 'marcio@f1sales.com.br'

        customer
      end

      let(:product) do
        product = OpenStruct.new
        product.name = 'CRV -'

        product
      end

      let(:lead) do
        lead = OpenStruct.new
        lead.message = 'como_deseja_ser_contatado?: e-mail: escolha_a_unidade_savol_kia: savol_kia_santo_andré quero Taxista'
        lead.source = source
        lead.customer = customer
        lead.product = product

        lead
      end

      it 'returns source name' do
        expect(described_class.switch_source(lead)).to eq('myHonda - Taxista')
      end
    end
  end

  context 'when product cotains CONSORCIO' do
    let(:source) do
      source = OpenStruct.new
      source.name = 'Facebook - Honda Flora'
      source
    end

    let(:customer) do
      customer = OpenStruct.new
      customer.name = 'Marcio'
      customer.phone = '1198788899'
      customer.email = 'marcio@f1sales.com.br'

      customer
    end

    let(:product) do
      product = OpenStruct.new
      product.name = 'CONSORCIO HONDA'

      product
    end

    let(:lead) do
      lead = OpenStruct.new
      lead.message = 'como_deseja_ser_contatado?: e-mail: escolha_a_unidade_savol_kia: savol_kia_santo_andré'
      lead.source = source
      lead.customer = customer
      lead.product = product

      lead
    end

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Consorcio')
    end
  end

  context 'when product cotains PCD' do

    let(:source) do
      source = OpenStruct.new
      source.name = 'Facebook - Honda Flora'
      source
    end

    let(:customer) do
      customer = OpenStruct.new
      customer.name = 'Marcio'
      customer.phone = '1198788899'
      customer.email = 'marcio@f1sales.com.br'

      customer
    end

    let(:product) do
      product = OpenStruct.new
      product.name = 'PcD FIT ABRIL 20'

      product
    end

    let(:lead) do
      lead = OpenStruct.new
      lead.message = 'como_deseja_ser_contatado?: e-mail: escolha_a_unidade_savol_kia: savol_kia_santo_andré'
      lead.source = source
      lead.customer = customer
      lead.product = product

      lead
    end

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - PCD')
    end
  end
end
