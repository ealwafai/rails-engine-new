class Api::V1::ItemsController < ApplicationController
  def index
    items = if params[:page] && params[:per_page]
                  Item.paginate(page: params[:page], per_page: params[:per_page])
                elsif params[:page].to_i >= 1
                  Item.paginate(page: params[:page], per_page: 20)
                elsif params[:per_page]
                  Item.paginate(page: 1, per_page: params[:per_page])
                else
                  Item.paginate(page: 1, per_page: 20)
                end
    json_response(ItemSerializer.new(items))
  end

  def show
    item = Item.find(params[:id])
    json_response(ItemSerializer.new(item))
  end

  def create
    item = Item.create!(item_params)
    json_response(ItemSerializer.new(item), :created)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
