class SynchronizeWinesWithDatasetJob < ApplicationJob
  queue_as :default

  def perform(*args)
    path = ENV.fetch("WINES_DATASET_PATH")
    Wines::Synchronizer.new(Rails.root.join(path)).call

    # reindex
    Wine.reindex
  rescue KeyError
    Rails.logger.error("WINES_DATASET_PATH environment variable not set")
  rescue StandardError
    Rails.logger.error(
      "An error occurred while synchronizing wines with dataset",
    )
  end
end
