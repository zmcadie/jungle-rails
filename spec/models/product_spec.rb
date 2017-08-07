require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should be valid with valid fields' do
      @category = Category.new(name: 'new category')
      @product = @category.products.new(name: 'new product',
                                        price: 1000,
                                        quantity: 3)
      expect(@product).to be_valid
    end

    it 'should not be valid without name' do
      @category = Category.new(name: 'new category')
      @product = @category.products.new(name: nil,
                                        price: 1000,
                                        quantity: 3)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eql ["Name can't be blank"]
    end

    it 'should not be valid without price' do
      @category = Category.new(name: 'new category')
      @product = @category.products.new(name: 'new product',
                                        price: nil,
                                        quantity: 3)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eql ["Price cents is not a number", "Price is not a number", "Price can't be blank"]
    end

    it 'should not be valid without quantity' do
      @category = Category.new(name: 'new category')
      @product = @category.products.new(name: 'new product',
                                        price: 1000,
                                        quantity: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eql ["Quantity can't be blank"]
    end

    it 'should not be valid without category' do
      @product = Product.new(name: 'new product',
                             price: 1000,
                             quantity: 3,
                             category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eql ["Category can't be blank"]
    end
  end
end
