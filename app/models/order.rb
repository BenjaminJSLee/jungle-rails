class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  before_create :validate_order
  after_create :decrement_products

  private

  def validate_order
    self.line_items.each do |item|
      if item.product.quantity - item.quantity < 0
        return false
      end
    end
    true
  end

  def decrement_products
    self.line_items.each do |item|
      item.product.quantity -= item.quantity
      item.product.save!
    end
  end

end
