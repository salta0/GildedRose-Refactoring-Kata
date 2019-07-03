# frozen_string_literal: true

# Dir[File.dirname(__FILE__) + 'quality_updater/*.rb'].each {|file| require file }

# it's abstract class that consist base update logic that same for all updaters
class QualityUpdater
  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(item)
    @item = item
  end

  protected

  def decrease_quality_by(num)
    if @item.quality > num
      @item.quality -= num
    else
      reset_quality
    end
  end

  def increase_quality_by(num)
    if (@item.quality + num) <= MAX_QUALITY
      @item.quality += num
    else
      @item.quality = MAX_QUALITY
    end
  end

  def reset_quality
    @item.quality = MIN_QUALITY
  end

  def decrease_sellin
    @item.sell_in -= 1
  end
end

# updater for aged brie items
class AdgedBrieUpdater < QualityUpdater
  def update_quality
    if @item.sell_in.positive?
      increase_quality_by 1
    else
      increase_quality_by 2
    end
    decrease_sellin
  end
end

# updater for backstage pass items
class BackstagePassUpdater < QualityUpdater
  def update_quality
    if @item.sell_in <= 10 && @item.sell_in > 5
      increase_quality_by 2
    elsif @item.sell_in <= 5 && @item.sell_in.positive?
      increase_quality_by 3
    elsif @item.sell_in <= 0
      reset_quality
    else
      increase_quality_by 1
    end
    decrease_sellin
  end
end

# updater for sulfuras do nothing
class SulfurasUpdater < QualityUpdater
  def update_quality; end
end

# updater for usual items
class UsualUpdater < QualityUpdater
  def update_quality
    if @item.sell_in.positive?
      decrease_quality_by 1
    else
      decrease_quality_by 2
    end
    decrease_sellin
  end
end
