class OffersController < ApplicationController
  def show
    @sale = sale_repository.get(params[:sale_id])
    @offer = offer_repository.get(params[:sale_id], params[:id])
  end

  private

  def offer_repository = OfferRepository.new
  def sale_repository = SaleRepository.new
end