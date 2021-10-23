class Api::V1::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.paginate(page: 1, per_page: 20)
    render json: MerchantSerializer.new(@merchants)
  end
end
