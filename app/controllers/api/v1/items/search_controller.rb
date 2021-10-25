class Api::V1::Items::SearchController < ApplicationController
  def find_all
    items = Item.find_by_name(params[:name])

    return json_response({ error: 'Bad request' }, :bad_request) unless params[:name].present?

    json_response(ItemSerializer.new(items))
  end
end
