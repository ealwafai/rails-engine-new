class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  belongs_to :merchant

  validates :name, :description, :unit_price, presence: true
  validates :unit_price, numericality: { greater_than: 0.0 }

  def self.find_by_name(query)
    where('name ilike ?', "%#{query}%")
      .order(Arel.sql('lower(name)')).to_a
  end

  def self.order_by_revenue(count)
    joins(invoices: :transactions)
      .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
      .where(invoices: { status: 'shipped' }, transactions: { result: 'success' })
      .group(:id)
      .order('revenue desc')
      .limit(count)
  end

  def self.find_by_price(price)
    if price[:min_price] && price[:max_price]
      where('unit_price > ?', price[:min_price]).where('unit_price < ?', price[:max_price]).to_a
    elsif price[:max_price]
      where('unit_price < ?', price[:max_price]).to_a
    elsif price[:min_price]
      where('unit_price > ?', price[:min_price]).to_a
    end
  end
end
