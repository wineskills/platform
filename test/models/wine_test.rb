require "test_helper"

class WineTest < ActiveSupport::TestCase
  test "success to build wine with default attributes" do
    wine = build(:wine)
    assert wine.valid?
  end

  %i[
    name
    alcohol_by_volume
    country_code
    vintages
    kind
    body
    acidity
  ].each do |attribute|
    test "fails to save wine without #{attribute} attribute" do
      wine = build(:wine, **{ attribute => nil })
      assert_not wine.valid?
    end
  end

  %i[kind body acidity].each do |attribute|
    test "fails to save wine with invalid #{attribute} attribute" do
      assert_raises(ArgumentError) do
        build(:wine, **{ attribute => "invalid" })
      end
    end
  end

  test "fails to save wine with invalid country_code attribute" do
    wine = build(:wine, country_code: "invalid")
    assert_not wine.valid?
  end

  test "fails to save wine with invalid alcohol_by_volume attribute" do
    wine = build(:wine, alcohol_by_volume: 1.5)
    assert_not wine.valid?
  end
end
