class ItemsController < ApplicationController
  before_action :authenticate_user!,only:[:new]


  def index
    @item = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :condition_id, :preparation_day_id, :prefecture_id, :postage_type_id, :category_id, :user).merge(user_id: current_user.id)
  end
end
