require "protos/Wines_pb"
require "protos/Wines_services_pb"

module Wineskills
  class WinesController < ::Gruf::Controllers::Base
    bind ::WineskillsRpc::Wines::Service

    ##
    # @return [Wineskils::GetWinesResponse] The wines response
    #
    def get_wines
      wines =
        Wine
          .all
          .limit(10)
          .map { |wine| WineskillsRpc::Wine.new(name: wine.name) }

      WineskillsRpc::GetWinesResponse.new(wines:)
    rescue StandardError => e
      set_debug_info(e.message, e.backtrace[0..4])
      fail!(:internal, :internal, "ERROR: #{e.message}")
    end
  end
end
