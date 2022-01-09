class SalesController < ApplicationController
  def new
    @sale = Sale.build_empty
  end
  
  def create
    sale = params[:sale]
    ActiveRecord::Base.transaction do
      id = SecureRandom.uuid
      command = Sales::Commands::CreateSale.new(sale_id: id, name: sale[:name], description: sale[:description])
      command_bus.(command)
      redirect_to sale_path(id)
    end
  end

  def show
    @sale = sale_repository.get(params[:id])
  end

  private

  def sale_repository = SaleRepository.new
end