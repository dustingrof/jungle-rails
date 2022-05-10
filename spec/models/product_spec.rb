require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @product = Product.new
    @category = Category.new name: 'test'
  end

  describe 'Validations' do
    it "saves product attributes" do
      @newProd = Product.new(name: 'tree', price: '123', quantity: '22', category: @category)
      expect(@newProd).to be_present
    end

    it "name exists" do
      if @product.name =  nil
      expect(@product.errors.messages[:name]).to include("can't be blank")
      end
    end

    it "price exists" do
      if @product.price =  nil
      expect(@product.errors.messages[:price]).to include("can't be blank")
      end
    end

    it "quantity exists" do
      if @product.quantity =  nil
      expect(@product.errors.messages[:quantity]).to include("can't be blank")
      end
    end

    it "category exists" do
      if @product.category =  nil
      expect(@product.errors.messages[:category]).to include("can't be blank")
      end
    end

  end
end
