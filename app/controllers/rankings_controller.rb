class RankingsController < ApplicationController
  def want
    @ranking_counts = Want.ranking
    set_items
  end

  def have
    @ranking_counts = Have.ranking
    set_items
  end

  private

  def set_items
    @items = Item.find(@ranking_counts.keys)
  end
end
