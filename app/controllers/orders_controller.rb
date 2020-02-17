class OrdersController < InheritedResources::Base
include CurrentCart
before_action :set_cart, only: [:new, :create]
before_action :set_order, only: [:show, :edit, :update, :destroy]

def create
  @order = Order.new(order_params)
  @order.add_line_items_from_cart(@cart)

  respond_to do |format|
    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      OrderNotifier.recieved(@order).deliver
      format.html {redirect_to store_url, notice: 'Thank u for ur order'}
      format.json {render action: 'show', status: :created, location: @order}
    else
      @cart = current_cart
      format.html {render action: 'new'}
      format.json { render json: @order.errors, status: :unprocessable_entity}
    end
  end
end

def new
  if @cart.line_items.empty?
    redirect_to store_url, notice: "Your cart is empty"
    return
  end

  @order=Order.new
end

  private

    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end

end
