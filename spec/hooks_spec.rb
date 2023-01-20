require File.expand_path 'spec_helper.rb', __dir__
require 'ostruct'
require 'f1sales_custom/hooks'

RSpec.describe F1SalesCustom::Hooks::Lead do
  let(:lead) do
    lead = OpenStruct.new
    lead.source = source
    lead.customer = customer
    lead.product = product

    lead
  end

  let(:customer) do
    customer = OpenStruct.new
    customer.name = 'Marcio'
    customer.phone = '1198788899'
    customer.email = 'marcio@f1sales.com.br'

    customer
  end

  let(:source) do
    source = OpenStruct.new
    source.name = 'Facebook - Honda Flora'
    source
  end

  let(:product) do
    product = OpenStruct.new
    product.name = nil

    product
  end

  context 'when has some taxi info' do
    before do
      source.name = 'myHonda'
    end

    context 'when product contains taxi' do
      before { product.name = 'Taxista -' }

      it 'returns source name' do
        expect(described_class.switch_source(lead)).to eq('myHonda - Taxista')
      end
    end

    context 'when message contains taxi' do
      before do
        product.name = 'CRV -'
        lead.message = 'como_deseja_ser_contatado?: e-mail: escolha_a_unidade_savol_kia: savol_kia_santo_andré quero Taxista'
      end

      it 'returns source name' do
        expect(described_class.switch_source(lead)).to eq('myHonda - Taxista')
      end
    end
  end

  context 'when product cotains CONSORCIO' do
    before do
      product.name = 'CONSORCIO HONDA'
    end

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Consorcio')
    end
  end

  context 'when product cotains PCD' do
    before do
      product.name = 'PcD FIT ABRIL 20'
    end

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('PCD')
    end
  end

  context 'when product contains Revisão - Aniversário Honda Flora -2021' do
    before do
      product.name = 'Revisão - Aniversário Honda Flora -2021'
    end

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Honda Flora - Revisão - Aniversário Honda Flora - 2021')
    end
  end

  context 'when product name is Isenções Outubro 2021' do
    before do
      product.name = 'Isenções Outubro 2021'
    end

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Honda Flora - Isenções Outubro 2021')
    end
  end

  context 'when product name is Honda New City 84 meses' do
    before do
      product.name = 'Honda New City 84 meses'
    end

    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Honda Flora - Consórcio')
    end
  end

  context 'when is a regular lead' do
    it 'returns source name' do
      expect(described_class.switch_source(lead)).to eq('Facebook - Honda Flora')
    end
  end
end
