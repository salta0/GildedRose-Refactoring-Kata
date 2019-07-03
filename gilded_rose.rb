# frozen_string_literal: true

require './updater_builder'

# class that represents Gilded Rose hotel
class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      updater = UpdaterBuilder.build_updater(item)
      updater.update_quality
    end
  end
end
