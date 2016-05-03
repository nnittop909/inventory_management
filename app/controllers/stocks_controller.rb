class StocksController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @stock = @product.stocks.build
  end

  def create
    @product = Product.find(params[:product_id])
    @stock = @product.stocks.create(stock_params)
    if @stock.save
      redirect_to @product, notice: "New stock saved successfully."
    else
      render :new
    end
  end

  private
  def stock_params
    params.require(:stock).permit(:quantity, :date)
  end
end