class WinesController < ApplicationController
  breadcrumb :wines, :wines_path

  def index
    @pagy, @wines = load_wines
  end

  def show
    @wine = Wine.includes(:grapes, :harmonizes).find(params[:id]).decorate
    breadcrumb @wine.name, @wine
  end

  private

  def load_wines
    if query = params[:q]
      collection = Wine.pagy_search(query, order: { _score: :desc })
      pagy_searchkick(collection)
    else
      pagy(Wine.includes(:region).with_attached_picture)
    end
  end
end
