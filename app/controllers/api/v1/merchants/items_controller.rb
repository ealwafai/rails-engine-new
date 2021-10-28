class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    if merchant_id_a_string
      return json_response({ error: "Couldn't find Merchant" }, :not_found)
    else
      merchant = Merchant.find(params[:id])
      items = merchant.items
      json_response(ItemSerializer.new(items))
    end


  end

  private

  def merchant_id_a_string
    params[:id].to_i.zero?
  end
end
