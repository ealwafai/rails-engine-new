class Api::V1::MerchantsController < ApplicationController
  def index
    if params[:page] && params[:per_page]
      merchants = Merchant.paginate(page: params[:page], per_page: params[:per_page])
      render json: MerchantSerializer.new(merchants)
    elsif params[:per_page]
      merchants = Merchant.paginate(page: 1, per_page: params[:per_page])
      render json: MerchantSerializer.new(merchants)
    elsif params[:page]
      merchants = Merchant.paginate(page: params[:page], per_page: 20)
      render json: MerchantSerializer.new(merchants)
    else
      merchants = Merchant.paginate(page: 1, per_page: 20)
      render json: MerchantSerializer.new(merchants)
    end
  end
end
