class WineDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper

  delegate_all

  def acidity
    object.acidity.capitalize
  end

  def body
    object.body.capitalize
  end

  def kind
    object.kind.capitalize
  end

  def harmonizes
    object.harmonizes.map(&:name).to_sentence
  end

  def grapes
    object.grapes.map(&:name).to_sentence
  end

  def vintages
    object.vintages.to_sentence
  end

  def alcohol_by_volume
    number_to_percentage(object.alcohol_by_volume * 100, precision: 1)
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
end
