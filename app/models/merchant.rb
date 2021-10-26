class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  def self.find_by_name(query)
    where('LOWER(name) LIKE ?', "%#{query.downcase}%")
      .order(:name)
      .first
  end

  def total_revenue
    Merchant
      .joins(items: { invoices: :transactions })
      .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
      .where(merchants: { id: id })
      .group('merchants.id').first
  end
end
