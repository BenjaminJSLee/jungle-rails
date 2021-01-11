require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before :each do
      @category = Category.new(:name => "Food")
      @category.save!
      @product = Product.new(
        :name => "Canned Olives", 
        :price_cents => 5000,
        :quantity => 120,
        :category_id => @category.id
      )
    end
    # validation tests/examples here
    it 'saves a product with no nil fields' do
      @product.save!
      expect(@product.errors.full_messages).to be_empty
    end

    it 'fails to save the product when the "name" field is nil' do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'fails to save the product when the "price_cents" field is nil' do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'fails to save the product when the "quantity" field is nil' do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'fails to save the product when the "category_id" field is nil' do
      @product.category_id = nil
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
