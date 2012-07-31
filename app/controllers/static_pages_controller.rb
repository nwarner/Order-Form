class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @product = current_user.products.build
      @display_items = current_user.display.paginate(page: params[:page])
    end
  end

  def contact
  end
end
