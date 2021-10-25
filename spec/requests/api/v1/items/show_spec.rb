require 'rails_helper'

RSpec.describe 'Items API Requests' do
  describe 'GET /items/:id' do
    context 'item exists' do
      it 'sends a specific item details' do
        item_1 = create(:item)

        get "/api/v1/items/#{item_1.id}"

        item = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(200)
        expect(item.count).to eq(1)
        expect(item[:data]).to be_a(Hash)

        expect(item[:data]).to have_key(:id)
        expect(item[:data][:id]).to be_an(String)

        expect(item[:data]).to have_key(:type)
        expect(item[:data][:type]).to eq('item')

        expect(item[:data]).to have_key(:attributes)
        expect(item[:data][:attributes]).to be_a(Hash)

        expect(item[:data][:attributes]).to have_key(:name)
        expect(item[:data][:attributes][:name]).to be_an(String)

        expect(item[:data][:attributes]).to have_key(:description)
        expect(item[:data][:attributes][:description]).to be_an(String)

        expect(item[:data][:attributes]).to have_key(:unit_price)
        expect(item[:data][:attributes][:unit_price]).to be_an(Float)
      end
    end

    context 'item does NOT exist' do
      it 'sends a status code 404' do
        get '/api/v1/items/123456'

        expect(response).to have_http_status(404)
        expect(response.body).to match(/Couldn't find Item/)
      end
    end

    context 'invalid request' do
      it 'sends a status code 404' do
        get '/api/v1/items/invalid'

        expect(response).to have_http_status(404)
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end
end
