class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:id])
    items = merchant.items

    return json_response({ error: 'Not found' }, :not_found) if merchant.nil?

    json_response(ItemSerializer.new(items))
  end
end
