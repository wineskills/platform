require "protos/Wines_pb"
require "protos/Wines_services_pb"

module Wineskills
  class WinesController < ::Gruf::Controllers::Base
    bind ::WineskillsRpc::Wines::Service

    ##
    # @return [WineskillsRpc::GetWinesResponse] The wines response
    #
    def get_wines
      wines =
        Wine
          .includes(:elaborate, :region, :winery)
          .map { |wine| serialize_wine(wine) }

      WineskillsRpc::GetWinesResponse.new(wines:)
    rescue StandardError => e
      set_debug_info(e.message, e.backtrace[0..4])
      fail!(:internal, :internal, "ERROR: #{e.message}")
    end

    ##
    # @return [WineskillsRpc::SearchWinesResponse] The wines response
    #
    def search_wines
      query = request.message.query
      wines =
        Wine
          .search(
            query,
            includes: %i[elaborate region winery],
            order: {
              _score: :desc,
            },
          )
          .map { |wine| serialize_wine(wine) }

      WineskillsRpc::SearchWinesResponse.new(wines:)
    rescue StandardError => e
      set_debug_info(e.message, e.backtrace[0..4])
      fail!(:internal, :internal, "ERROR: #{e.message}")
    end

    private

    def serialize_wine(wine)
      wine.decorate.try do |wine|
        WineskillsRpc::Wine.new(
          name: wine.name,
          kind: wine.kind,
          body: wine.body,
          acidity: wine.acidity,
          alcohol_by_volume: wine.alcohol_by_volume,
          country: wine.country.iso_short_name,
          elaborate: wine.elaborate.name,
          region: wine.region.name,
          winery: wine.winery.name,
        )
      end
    end
  end
end
