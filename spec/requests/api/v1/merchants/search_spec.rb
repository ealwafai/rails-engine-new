require 'rails_helper'

RSpec.describe 'Merchants Search' do
  describe 'GET /api/v1/merchants/find' do
    before :each do
      @merchant_1 = create(:merchant, name: 'Matt')
      @merchant_2 = create(:merchant, name: 'Brett')
      @merchant_3 = create(:merchant, name: 'Brian')
    end

    context 'at least one merchant that matches' do
      context 'only one match' do
        it 'returns the single match' do
          get '/api/v1/merchants/find', params: { name: 'Bre' }

          result = JSON.parse(response.body, symbolize_names: true)
          data = result[:data]
          expect(response).to have_http_status(200)
          expect(data).to be_a(Hash)
          expect(data[:id]).to eq(@merchant_2.id.to_s)
          expect(data[:type]).to eq('merchant')
          expect(data[:attributes]).to be_a(Hash)
          expect(data[:attributes]).to have_key(:name)
          expect(data[:attributes][:name]).to eq(@merchant_2.name)
        end
      end

      context 'more than one possible matches' do
        it 'returns the single match that comes first in case-insensitive order' do
          get '/api/v1/merchants/find', params: { name: 'Br' }

          result = JSON.parse(response.body, symbolize_names: true)

          data = result[:data]

          expect(response).to have_http_status(200)
          expect(data).to be_a(Hash)
          expect(data[:id]).to eq(@merchant_2.id.to_s)
          expect(data[:type]).to eq('merchant')
          expect(data[:attributes]).to be_a(Hash)
          expect(data[:attributes]).to have_key(:name)
          expect(data[:attributes][:name]).to eq(@merchant_2.name)
        end
      end
    end

    context 'no matches found' do
      it 'returns an empty json response and status code 200' do
        get '/api/v1/merchants/find', params: { name: 'John' }

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(200)
        expect(result[:data]).to be_a(Hash)
        expect(result).to have_key(:data)
        expect(result[:data]).to eq({})
      end
    end
  end
end
