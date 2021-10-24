require 'rails_helper'

RSpec.describe 'Items API Requests' do
  describe 'PATCH /items/:id' do
    context 'item exits' do
      context 'all attributes are present and valid' do
        it 'updates the item and returns a 202 status code' do
          merchant = create(:merchant)
          item = create(:item, merchant: merchant)
          item_params = {
            name: 'New Item Name',
            description: 'New Item Description',
            unit_price: 110.50,
            merchant_id: merchant.id
          }
          headers = {"CONTENT_TYPE" => "application/json"}

          patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params)

          updated_item = Item.find(item.id)

          expect(response).to have_http_status(202)

          expect(updated_item.name).to eq(item_params[:name])
          expect(updated_item.description).to eq(item_params[:description])
          expect(updated_item.unit_price).to eq(item_params[:unit_price])
          expect(updated_item.merchant_id).to eq(item_params[:merchant_id])

          response_item = JSON.parse(response.body, symbolize_names: true)

          expect(response_item[:data]).to be_a(Hash)

          data = response_item[:data]
          expect(data[:id]).to eq(item.id.to_s)
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

      context 'only one attribute is present and valid' do
        it 'updates the item and returns a 202 status code' do
          merchant = create(:merchant)
          item = create(:item, merchant: merchant)
          item_params = {
            name: 'New Item Name',
          }
          headers = {"CONTENT_TYPE" => "application/json"}

          patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params)

          updated_item = Item.find(item.id)

          expect(response).to have_http_status(202)

          expect(updated_item.name).to eq(item_params[:name])
          expect(updated_item.description).to eq(item.description)
          expect(updated_item.unit_price).to eq(item.unit_price)
          expect(updated_item.merchant_id).to eq(merchant.id)
        end
      end

      context 'invalid attribute is present' do
        it 'returns a failure message and 404 if merchant not found, will not update' do
          merchant = create(:merchant)
          item = create(:item, merchant: merchant)
          item_params = {
            name: 'New Item Name',
            description: 'New Item Description',
            unit_price: 110.50,
            merchant_id: 123456
          }
          headers = {"CONTENT_TYPE" => "application/json"}

          patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params)

          expect(Item.find(item.id).unit_price).to eq(item.unit_price)

          expect(response).to have_http_status(422)
          expect(response.body).to match(/Merchant must exist/)
        end

        it 'returns a failure message and 422 if validations fail, will not update' do
          merchant = create(:merchant)
          item = create(:item, merchant: merchant)
          item_params = {
            name: 'New Item Name',
            description: 'New Item Description',
            unit_price: 'unit price',
            merchant_id: merchant.id
          }
          headers = {"CONTENT_TYPE" => "application/json"}

          patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params)

          expect(Item.find(item.id).unit_price).to eq(item.unit_price)

          expect(response).to have_http_status(422)
          expect(response.body).to match(/Unit price is not a number/)
        end
      end

      context 'non-standard attributes are present' do
        it 'updates the item, returns a 202 status, and ignores the extra attributes' do
          merchant = create(:merchant)
          item = create(:item, merchant: merchant)
          item_params = {
            unit_price: 110.50,
            new_param: 'new param'
          }
          headers = {"CONTENT_TYPE" => "application/json"}

          patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params)

          updated_item = Item.find(item.id)

          expect(response).to have_http_status(202)

          expect(updated_item.name).to eq(item.name)
          expect(updated_item.description).to eq(item.description)
          expect(updated_item.unit_price).to eq(item_params[:unit_price])
          expect(updated_item.merchant_id).to eq(merchant.id)

          response_item = JSON.parse(response.body, symbolize_names: true)

          expect(response_item[:data]).to be_a(Hash)

          data = response_item[:data]
          expect(data[:id]).to eq(item.id.to_s)
          expect(data[:type]).to eq('item')
          expect(data[:attributes]).to be_a(Hash)

          expect(data[:attributes]).not_to have_key(:extra_param)

          expect(data[:attributes]).to have_key(:name)
          expect(data[:attributes]).to have_key(:description)
          expect(data[:attributes]).to have_key(:unit_price)
          expect(data[:attributes]).to have_key(:merchant_id)
        end
      end
    end

    context 'item does NOT exit' do
      it 'returns a failure message and 404 status code' do
        merchant = create(:merchant)
        item_params = {
          name: 'New Item Name',
          description: 'New Item Description',
          unit_price: 110.50,
          merchant_id: merchant.id
        }
        headers = {"CONTENT_TYPE" => "application/json"}

        patch "/api/v1/items/string", headers: headers, params: JSON.generate(item: item_params)

        expect(response).to have_http_status(404)
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end
end
