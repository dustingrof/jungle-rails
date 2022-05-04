class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["HTTP_BASIC_USER"],
                               password: ENV["HTTP_BASIC_PASSWORD"],
                               if: -> { ENV["HTTP_BASIC_PASSWORD"].present? }
  def show
    @number_of_products = Product.count
    @number_of_categories = Category.count
  end

end
