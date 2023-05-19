require File.expand_path 'spec_helper.rb', __dir__
require 'ostruct'
require 'f1sales_custom/hooks'

RSpec.describe F1SalesCustom::Hooks::Lead do
  describe '.switch_source' do
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

    let(:switch_source) { described_class.switch_source(lead) }

    context 'when has some taxi info' do
      before do
        source.name = 'myHonda'
      end

      context 'when product contains taxi' do
        before { product.name = 'Taxista -' }

        it 'returns source name' do
          expect(switch_source).to eq('myHonda - Taxista')
        end
      end

      context 'when message contains taxi' do
        before do
          product.name = 'CRV -'
          lead.message = 'como_deseja_ser_contatado?: e-mail: escolha_a_unidade_savol_kia: savol_kia_santo_andré quero Taxista'
        end

        it 'returns source name' do
          expect(switch_source).to eq('myHonda - Taxista')
        end
      end
    end

    context 'when product cotains CONSORCIO' do
      before { product.name = 'CONSORCIO HONDA' }

      it 'returns source name' do
        expect(switch_source).to eq('Facebook - Honda Flora - Consórcio')
      end
    end

    context 'when product cotains PCD' do
      before { product.name = 'PcD FIT ABRIL 20' }

      it 'returns source name' do
        expect(switch_source).to eq('PCD')
      end
    end

    context 'when product name is Honda New City 84 meses' do
      before { product.name = 'Honda New City 84 meses' }

      it 'returns source name' do
        expect(switch_source).to eq('Facebook - Honda Flora - Consórcio')
      end
    end

    context 'when is a regular lead' do
      it 'returns source name' do
        expect(switch_source).to eq('Facebook - Honda Flora')
      end
    end

    context 'when is a regular lead' do
      before { product.name = 'SEMINOVOS COOPERADA MARCO 2023' }

      it 'returns source name' do
        expect(switch_source).to eq('Facebook - Honda Flora - Heater')
      end
    end
  end
end
