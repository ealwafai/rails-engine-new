require 'rails_helper'

RSpec.describe 'Items API Requests' do
  context 'all attributes are present and valid' do
    it 'creates an item and returns a 201 status code' do
      merchant = create(:merchant)
      item_params = {
        name: 'Item Name',
        description: 'Item Description',
        unit_price: 110.50,
        merchant_id: merchant.id
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      created_item = Item.last
      expect(response).to have_http_status(201)
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data]).to be_a Hash

      data = item[:data]
      expect(data[:id]).to eq(created_item.id.to_s)
      expect(data[:type]).to eq('item')
      expect(data[:attributes]).to be_a(Hash)

      expect(data[:attributes]).to have_key(:name)
      expect(data[:attributes][:name]).to be_an(String)

      expect(data[:attributes]).to have_key(:description)
      expect(data[:attributes][:description]).to be_an(String)

      expect(data[:attributes]).to have_key(:unit_price)
      expect(data[:attributes][:unit_price]).to be_an(Float)

      expect(data[:attributes]).to have_key(:merchant_id)
      expect(data[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  context 'attributes are present but invalid' do
    it 'returns a failure message and 422 status code' do
      merchant = create(:merchant)
      item_params = {
        name: 'Item Name',
        description: 'Item Description',
        unit_price: 'price',
        merchant_id: merchant.id
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      expect(response).to have_http_status(422)
      expect(response.body).to match(/Validation failed: Unit price is not a number/)
    end

    it 'cannot create an item without a valid merchant id' do
      item_params = {
        name: 'Item Name',
        description: 'Item Description',
        unit_price: '110.50',
        merchant_id: 1
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      expect(response).to have_http_status(422)
      expect(response.body).to match(/Validation failed: Merchant must exist/)
    end
  end

  context 'attributes are NOT present' do
    it 'returns a failure message and status code 422' do
      merchant = create(:merchant)
      item_params = {
        name: 'Item Name',
        description: 'Item Description',
        merchant_id: merchant.id
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      expect(response).to have_http_status(422)
      expect(response.body).to match(/Validation failed: Unit price can't be blank/)
    end
  end
end
