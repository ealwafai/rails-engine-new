require 'rails_helper'

RSpec.describe 'Items API Requests' do
  describe 'GET /items' do
    context 'when params are NOT present' do
      it 'sends a list of first 20 items with default params' do
        create_list(:item, 30)

        get '/api/v1/items'

        items = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(200)
        expect(items[:data].count).to eq(20)
        expect(items[:data]).to be_a(Array)

        items[:data].each do |item|
          expect(item).to have_key(:id)
          expect(item[:id]).to be_an(String)

          expect(item).to have_key(:type)
          expect(item[:type]).to eq('item')

          expect(item).to have_key(:attributes)
          expect(item[:attributes]).to be_a(Hash)

          expect(item[:attributes]).to have_key(:name)
          expect(item[:attributes][:name]).to be_an(String)

          expect(item[:attributes]).to have_key(:description)
          expect(item[:attributes][:description]).to be_an(String)

          expect(item[:attributes]).to have_key(:unit_price)
          expect(item[:attributes][:unit_price]).to be_an(Float)
        end
      end
    end

    context 'when no data is available' do
      it 'sends an empty array' do
        get '/api/v1/items'

        items = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(200)
        expect(items[:data]).to eq([])
      end
    end

    context 'when params are present' do
      context 'when both params are specified' do
        it 'sends the appropriate list of items based on params' do
          create_list(:item, 30)

          all_items = Item.all

          get '/api/v1/items', params: { per_page: 10, page: 2 }

          items = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(200)
          expect(items[:data].count).to eq(10)
          expect(items[:data]).to be_a(Array)

          expect(items[:data].first[:id]).to eq(all_items[10].id.to_s)
          expect(items[:data].last[:id]).to eq(all_items[19].id.to_s)

          items[:data].each do |item|
            expect(item).to have_key(:id)
            expect(item[:id]).to be_an(String)

            expect(item).to have_key(:type)
            expect(item[:type]).to eq('item')

            expect(item).to have_key(:attributes)
            expect(item[:attributes]).to be_a(Hash)

            expect(item[:attributes]).to have_key(:name)
            expect(item[:attributes][:name]).to be_an(String)

            expect(item[:attributes]).to have_key(:description)
            expect(item[:attributes][:description]).to be_an(String)

            expect(item[:attributes]).to have_key(:unit_price)
            expect(item[:attributes][:unit_price]).to be_an(Float)
          end
        end
      end

      context 'only when per_page is specified' do
        it 'sends the appropriate list of items, page defaults to 1' do
          create_list(:item, 30)

          all_items = Item.all

          get '/api/v1/items', params: { per_page: 10 }

          items = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(200)
          expect(items[:data].count).to eq(10)
          expect(items[:data]).to be_a(Array)

          expect(items[:data].first[:id]).to eq(all_items[0].id.to_s)
          expect(items[:data].last[:id]).to eq(all_items[9].id.to_s)

          items[:data].each do |item|
            expect(item).to have_key(:id)
            expect(item[:id]).to be_an(String)

            expect(item).to have_key(:type)
            expect(item[:type]).to eq('item')

            expect(item).to have_key(:attributes)
            expect(item[:attributes]).to be_a(Hash)

            expect(item[:attributes]).to have_key(:name)
            expect(item[:attributes][:name]).to be_an(String)

            expect(item[:attributes]).to have_key(:description)
            expect(item[:attributes][:description]).to be_an(String)

            expect(item[:attributes]).to have_key(:unit_price)
            expect(item[:attributes][:unit_price]).to be_an(Float)
          end
        end
      end

      context 'only when page is specified' do
        it 'sends the appropriate list of items, per_page defaults to 20' do
          create_list(:item, 30)

          all_items = Item.all

          get '/api/v1/items', params: { page: 2 }

          items = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(200)
          expect(items[:data].count).to eq(10)
          expect(items[:data]).to be_a(Array)

          expect(items[:data].first[:id]).to eq(all_items[20].id.to_s)
          expect(items[:data].last[:id]).to eq(all_items[29].id.to_s)

          items[:data].each do |item|
            expect(item).to have_key(:id)
            expect(item[:id]).to be_an(String)

            expect(item).to have_key(:type)
            expect(item[:type]).to eq('item')

            expect(item).to have_key(:attributes)
            expect(item[:attributes]).to be_a(Hash)

            expect(item[:attributes]).to have_key(:name)
            expect(item[:attributes][:name]).to be_an(String)

            expect(item[:attributes]).to have_key(:description)
            expect(item[:attributes][:description]).to be_an(String)

            expect(item[:attributes]).to have_key(:unit_price)
            expect(item[:attributes][:unit_price]).to be_an(Float)
          end
        end

        it 'defaults to page 1 if page param is specified as < 1' do
          create_list(:item, 30)

          all_items = Item.all

          get '/api/v1/items', params: { page: -1 }

          items = JSON.parse(response.body, symbolize_names: true)

          expect(items[:data].count).to eq(20)
          expect(items[:data]).to be_a(Array)

          expect(items[:data].first[:id]).to eq(all_items.first.id.to_s)
          expect(items[:data].last[:id]).to eq(all_items[19].id.to_s)

          items[:data].each do |item|
            expect(item).to have_key(:id)
            expect(item[:id]).to be_an(String)

            expect(item).to have_key(:type)
            expect(item[:type]).to eq('item')

            expect(item).to have_key(:attributes)
            expect(item[:attributes]).to be_a(Hash)

            expect(item[:attributes]).to have_key(:name)
            expect(item[:attributes][:name]).to be_an(String)

            expect(item[:attributes]).to have_key(:description)
            expect(item[:attributes][:description]).to be_an(String)

            expect(item[:attributes]).to have_key(:unit_price)
            expect(item[:attributes][:unit_price]).to be_an(Float)
          end
        end
      end
    end
  end
end
