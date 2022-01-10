class SalesController < ApplicationController
  def show
    @sale = sale_repository.get(params[:id])
    @offers = offer_repository.by_sale(params[:id])
  end

  private

  def sale_repository = SaleRepository.new
  def offer_repository = OfferRepository.new
end