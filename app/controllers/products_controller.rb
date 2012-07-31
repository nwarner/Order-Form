class ProductsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def create
    @product = current_user.products.build(params[:product])
    if @product.save
      flash[:success] = "Product created!"
      redirect_to root_path
    else
      @display_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private

    def correct_user
      @product = current_user.products.find_by_id(params[:id])
      redirect_to root_path if @product.nil?
    end
end
