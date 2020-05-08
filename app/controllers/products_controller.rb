class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
attr_accessor

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.older(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
      end
    end
  end

  def index
    if can? :read, @product
      @products = Product.search(params[:search])
    end
  end

  def show
    if can? :read, @product
      @product=Product.find(params[:id])
    end
  end


  def new
    if can? :create, @product
      @product = Product.new
    end
  end


  def edit
    end


  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    if can? :update, @product
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to @product, notice: 'Product was successfully updated.' }
          format.json { render :show, status: :ok, location: @product }
        else
          format.html { render :edit }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  def destroy
    if can? :destroy, @product
      @product.destroy
      respond_to do |format|
        format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price, :search)
    end
end
