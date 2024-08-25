class WinesController < ApplicationController
  breadcrumb :wines, :wines_path

  def index
    @pagy, @wines =
      pagy(Wine.includes(:elaborate, :region, :winery, :grapes, :harmonizes))
  end

  def show
    @wine = Wine.find(params[:id]).decorate
    breadcrumb @wine.name, @wine
  end
end
