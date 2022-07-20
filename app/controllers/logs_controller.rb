class LogsController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index, only: [:index, :create]
  before_action :find_params, only:[:index, :create]

  def index
    @log_destination = LogDestination.new
  end

  def create
    @log_destination = LogDestination.new(destination_params)
    if @log_destination.valid?
       pay_item
       @log_destination.save
       redirect_to root_path 
    else
      render :index
    end
  end

  private

  def destination_params
    params.require(:log_destination).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def find_params
    @item = Item.find(params[:id])
  end

  def pay_item
    Payjp.api_key = "sk_test_0d2302886ae7fc6ca456caa8"
    Payjp::Charge.create(
      amount: @item.price,        
      card: destination_params[:token],  
      currency: 'jpy'             
    )
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id || @item.log.present?
  end


end
