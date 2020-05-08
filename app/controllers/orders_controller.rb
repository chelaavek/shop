class OrdersController < InheritedResources::Base
include CurrentCart
before_action :set_cart, only: [:new, :create]


def index
  if can? :read, @order
    @orders = Order.where(email: current_admin_user.email)
  end
end

def show
  if can? :read, @order
    @order = Order.find(params[:id])
  end
end

def create
    @order = Order.new(order_params)
    if current_admin_user
      @order.email = current_admin_user.email
    end
    @order.add_line_items_from_cart(@cart)
    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderNotifierMailer.received(@order).deliver
        format.html {redirect_to store_url, notice: 'Thank u for ur order'}
        format.json {render action: 'show', status: :created, location: @order}
      else
        format.html {render action: 'new'}
        format.json { render json: @order.errors, status: :unprocessable_entity}
      end
    end
end

def new
    if @cart.line_items.empty?
      redirect_to store_url, notice: 'Your cart is empty'
      return
    end
    @order=Order.new
end

def destroy
  @order = Order.find(params[:id])
  if current_admin_user.email == @order.email
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
  end
  end
end

  private

    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type, :phone_number, :id)
    end

end
