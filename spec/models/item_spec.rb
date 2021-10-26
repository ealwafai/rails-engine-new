require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price).is_greater_than(0.0) }
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

    describe '.order_by_revenue' do
      it 'returns a list of items by revenue descending' do
        merchant = create(:merchant, id: 1)

        customer_1 = create(:customer)
        customer_2 = create(:customer)

        item_1 = create(:item, merchant: merchant)
        item_2 = create(:item, merchant: merchant)
        item_3 = create(:item, merchant: merchant)

        invoice_1 = create(:invoice, merchant: merchant, customer: customer_1, status: 'shipped')
        invoice_2 = create(:invoice, merchant: merchant, customer: customer_2, status: 'shipped')
        invoice_3 = create(:invoice, merchant: merchant, customer: customer_1, status: 'shipped')

        invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 12, unit_price: 1.564)
        invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 5, unit_price: 2.65415)
        invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_3, quantity: 20, unit_price: 2.65415)

        transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')
        transaction_2 = create(:transaction, invoice: invoice_2, result: 'success')
        transaction_3 = create(:transaction, invoice: invoice_3, result: 'success')

        expect(Item.order_by_revenue(3)).to eq([item_3, item_1, item_2])
      end
    end
  end
end
