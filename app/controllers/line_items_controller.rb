class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  def destroy
    @line_item.destroy if :cart_id == session[:cart_id]
  end


  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product( product.id)
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_url}
        format.js { @current_item = @line_item }
        format.json { render action: 'show', status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def line_item_params
      params.require(:line_item).permit(:product_id)
    end

end

