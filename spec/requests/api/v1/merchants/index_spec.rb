require 'rails_helper'

RSpec.describe 'Merchants API Requests' do
  describe 'GET /merchants' do
    context 'when params are NOT present' do
      it 'sends a list of first 20 merchants with default params' do
        create_list(:merchant, 30)

        get '/api/v1/merchants'

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(merchants[:data].count).to eq(20)

        merchants[:data].each do |merchant|
          expect(merchant).to have_key(:id)
          expect(merchant[:id]).to be_an(String)

          expect(merchant).to have_key(:type)
          expect(merchant[:type]).to eq('merchant')

          expect(merchant).to have_key(:attributes)
          expect(merchant[:attributes]).to be_a(Hash)

          expect(merchant[:attributes]).to have_key(:name)
          expect(merchant[:attributes][:name]).to be_an(String)
        end
      end
    end

    # context 'when no data is available' do
    #
    # end
    #
    # context 'when params are present' do
    #
    # end
  end
end
