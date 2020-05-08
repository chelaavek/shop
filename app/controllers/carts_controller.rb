class CartsController < InheritedResources::Base
rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

def destroy
  @cart = Cart.find(params[:id])
  if can? :destroy, @cart
    @cart.destroy if :cart_id == session[:cart_id]
    session[:cart_id] = nil
    respond_to do |format|
      format.html {redirect_to store_url}
      format.json { head :no_content}
    end
  end
end

  private

    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to store_url, notice: 'Invalid cart'
    end

    def cart_params
      params.require(:cart).permit()
    end
end

