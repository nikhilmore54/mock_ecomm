class CartItemsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_cart, only: [:create, :destroy]
  before_action :set_cart_item, only: [:destroy]

  def create
    @cart.add_photo(params)
    @cart.user_id = current_user.id

    if @cart.save
      debugger
      redirect_to cart_path
    else
      flash[:error] = 'There was a problem adding the image to cart'
      redirect_to photos_path
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_path
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])    
  end

  def cart_item_params
    params.require(:cart_item).permit(:photo_id, :cart_id, :quantity)
  end
end
