class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit]
  before_action :prevent_url, only: [:edit, :update, :destroy]
  before_action :find_params, only:[:show, :edit, :update,]

  def index
    @item = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end
  
  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
   end


  private
  
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :condition_id, :preparation_day_id, :prefecture_id, :postage_type_id, :category_id, :user).merge(user_id: current_user.id)
  end

  def prevent_url
    @item = Item.find(params[:id])
    if @item.user_id != current_user.id
      redirect_to root_path
    end
  end

  def find_params
    @item = Item.find(params[:id])
  end
end
