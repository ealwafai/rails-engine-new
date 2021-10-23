class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = if params[:page] && params[:per_page]
                  Merchant.paginate(page: params[:page], per_page: params[:per_page])
                elsif params[:page].to_i >= 1
                  Merchant.paginate(page: params[:page], per_page: 20)
                elsif params[:per_page]
                  Merchant.paginate(page: 1, per_page: params[:per_page])
                else
                  Merchant.paginate(page: 1, per_page: 20)
                end
    render json: MerchantSerializer.new(merchants)
  end
end
