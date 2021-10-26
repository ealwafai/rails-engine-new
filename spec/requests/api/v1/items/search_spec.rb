require 'rails_helper'

RSpec.describe 'search items' do
  describe 'GET /api/v1/items/find_all' do
    before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
    end

    context 'search by name' do
      context 'matches are found' do
        it 'returns items matching that search by name' do
          item_1 = create(:item, name: 'North Star', merchant: @merchant_1)
          item_2 = create(:item, name: 'south star', merchant: @merchant_2)
          item_3 = create(:item, name: 'planets', merchant: @merchant_2)

          get '/api/v1/items/find_all', params: { name: 'star' }

          result = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(200)
          expect(result[:data]).to be_an(Array)
          expect(result[:data].length).to eq(2)

          first_item = result[:data].first
          expect(first_item[:id]).to eq(item_1.id.to_s)
          expect(first_item[:type]).to eq('item')
          expect(first_item[:attributes][:name]).to eq(item_1.name)

          second_item = result[:data].second
          expect(second_item[:id]).to eq(item_2.id.to_s)
          expect(second_item[:type]).to eq('item')
          expect(second_item[:attributes][:name]).to eq(item_2.name)
        end
      end

      context 'no matches found' do
        it 'returns a 200 status code and empty array' do
          get '/api/v1/items/find_all', params: { name: 'star' }

          result = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(200)
          expect(result[:data]).to be_an(Array)
          expect(result[:data]).to be_empty
        end
      end
    end

    context 'params are empty' do
      it 'returns an error and 400 status code' do
        item = create(:item, name: 'North Star', merchant: @merchant_1)

        get '/api/v1/items/find_all', params: { name: nil }

        expect(response).to have_http_status(400)
      end
    end
  end
end