require 'rails_helper'

RSpec.describe 'Merchants API Requests' do
  describe 'GET /merchants' do
    context 'when params are NOT present' do
      it 'sends a list of first 20 merchants with default params' do
        create_list(:merchant, 30)

        get '/api/v1/merchants'

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(200)
        expect(merchants[:data].count).to eq(20)
        expect(merchants[:data]).to be_a(Array)


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

    context 'when no data is available' do
      it 'sends an empty array' do
        get '/api/v1/merchants'

        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(200)
        expect(merchants[:data]).to eq([])
      end
    end

    context 'when params are present' do
      context 'when both params are specified' do
        it 'sends the appropriate list of merchants based on params' do
          create_list(:merchant, 30)

          all_merchants = Merchant.all

          get '/api/v1/merchants', params: { per_page: 10, page: 2 }

          merchants = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(200)
          expect(merchants[:data].count).to eq(10)
          expect(merchants[:data]).to be_a(Array)

          expect(merchants[:data].first[:id]).to eq(all_merchants[10].id.to_s)
          expect(merchants[:data].last[:id]).to eq(all_merchants[19].id.to_s)

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

      context 'only when per_page is specified' do
        it 'sends the appropriate list of merchants, page defaults to 1' do
          create_list(:merchant, 30)

          all_merchants = Merchant.all

          get '/api/v1/merchants', params: { per_page: 10 }

          merchants = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(200)
          expect(merchants[:data].count).to eq(10)
          expect(merchants[:data]).to be_a(Array)

          expect(merchants[:data].first[:id]).to eq(all_merchants[0].id.to_s)
          expect(merchants[:data].last[:id]).to eq(all_merchants[9].id.to_s)

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

      context 'only when page is specified' do
        it 'sends the appropriate list of merchants, per_page defaults to 20' do
          create_list(:merchant, 30)

          all_merchants = Merchant.all

          get '/api/v1/merchants', params: { page: 2 }

          merchants = JSON.parse(response.body, symbolize_names: true)

          expect(response).to have_http_status(200)
          expect(merchants[:data].count).to eq(10)
          expect(merchants[:data]).to be_a(Array)

          expect(merchants[:data].first[:id]).to eq(all_merchants[20].id.to_s)
          expect(merchants[:data].last[:id]).to eq(all_merchants[29].id.to_s)

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

        it 'defaults to page 1 if page param is specified as < 1' do
          create_list(:merchant, 30)

          all_merchants = Merchant.all

          get '/api/v1/merchants', params: { page: -1 }

          merchants = JSON.parse(response.body, symbolize_names: true)

          expect(merchants[:data].count).to eq(20)
          expect(merchants[:data]).to be_a(Array)

          expect(merchants[:data].first[:id]).to eq(all_merchants.first.id.to_s)
          expect(merchants[:data].last[:id]).to eq(all_merchants[19].id.to_s)

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
    end
  end
end
