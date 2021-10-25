require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end

  describe 'class methods' do
    describe '.find_by_name' do
      it 'returns a list of matching items by name' do
        item_1 = create(:item, name: 'North Star', merchant: @merchant_1)
        item_2 = create(:item, name: 'south star', merchant: @merchant_2)
        item_3 = create(:item, name: 'galaxies', description: 'galaxy formation', merchant: @merchant_2)

        expect(Item.find_by_name('star')).to be_an(Array)
        expect(Item.find_by_name('star').length).to eq(2)
        expect(Item.find_by_name('star').first).to eq(item_1)
        expect(Item.find_by_name('star').second).to eq(item_2)
        expect(Item.find_by_name('star')).not_to include(item_3)
      end

      it 'returns empty array if no matching items exist' do
        expect(Item.find_by_name('star')).to be_an(Array)
        expect(Item.find_by_name('star')).to(be_empty)
      end
    end
  end
end
