require 'rails_helper'

RSpec.describe 'Merchants API Requests' do
  describe 'GET /merchants/:id' do
    context 'merchant exists' do
      it 'sends a specific merchant details' do
        merchant_1 = create(:merchant)

        get "/api/v1/merchants/#{merchant_1.id}"

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(200)
        expect(merchant.count).to eq(1)
        expect(merchant[:data]).to be_a(Hash)

        expect(merchant[:data]).to have_key(:id)
        expect(merchant[:data][:id]).to be_an(String)

        expect(merchant[:data]).to have_key(:type)
        expect(merchant[:data][:type]).to eq('merchant')

        expect(merchant[:data]).to have_key(:attributes)
        expect(merchant[:data][:attributes]).to be_a(Hash)

        expect(merchant[:data][:attributes]).to have_key(:name)
        expect(merchant[:data][:attributes][:name]).to be_an(String)
      end
    end

    context 'merchant does NOT exist' do
      it 'sends a status code 404' do
        get '/api/v1/merchants/123456'

        expect(response).to have_http_status(404)
        expect(response.body).to match(/Couldn't find Merchant/)
      end
    end

    context 'invalid request' do
      it 'sends a status code 404' do
        get '/api/v1/merchants/invalid'

        expect(response).to have_http_status(404)
        expect(response.body).to match(/Couldn't find Merchant/)
      end
    end
  end
end
