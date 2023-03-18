class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with :name => "Jungle", :password => "book" 

  def show
    @products = product_counts
    @categories = category_counts
  end

  def product_counts
    product_quant = 0
    Product.find_each do |product_count|
       product_quant += product_count.quantity
    end
    product_quant
  end

  def category_counts
    return Category.count
  end
end
