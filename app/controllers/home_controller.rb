class HomeController < ApplicationController
  def index
    @sales = sale_repository.all

    if params[:q].present?
      @offers = offers_repository.search(params[:q])
    end
  end

  private

  def sale_repository = SaleRepository.new

  def offers_repository = OfferRepository.new
end
