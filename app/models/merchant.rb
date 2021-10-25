class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  def self.find_by_name(query)
    where('LOWER(name) LIKE ?', "%#{query.downcase}%")
      .order(:name)
      .first
  end
end
