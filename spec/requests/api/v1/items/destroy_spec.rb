require 'rails_helper'

RSpec.describe 'Items API Requests' do
  describe 'DESTROY /items/:id' do
      context 'item exists' do
        it 'destroys the item' do
          merchant = create(:merchant)
          item = create(:item, merchant: merchant)

          delete "/api/v1/items/#{item.id}"

          expect(response).to have_http_status(204)
          expect(response.body).to eq ''
        end
      end

      context 'item does not exist' do
        it 'returns a failure message and 404 status code' do
          merchant = create(:merchant)

          delete '/api/v1/items/12345'

          expect(response).to have_http_status(404)
          expect(response.body).to match(/Couldn't find Item/)
        end
      end
    end
  end
