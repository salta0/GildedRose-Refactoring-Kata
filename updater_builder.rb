# frozen_string_literal: true

require './quality_updater'

# factory that builds updater for each type of item
class UpdaterBuilder
  BRIE_NAME = 'Aged Brie'
  PASS_NAME = 'Backstage passes to a TAFKAL80ETC concert'
  SULFURAS_NAME = 'Sulfuras, Hand of Ragnaros'

  def self.build_updater(item)
    case item.name
    when BRIE_NAME
      AdgedBrieUpdater.new item
    when PASS_NAME
      BackstagePassUpdater.new item
    when SULFURAS_NAME
      SulfurasUpdater.new item
    else
      UsualUpdater.new item
    end
  end
end
