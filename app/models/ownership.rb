class Ownership < ApplicationRecord
  belongs_to :user
  belongs_to :item

  OWNERSHIP_OPTIONS = %w(Want Have)

  def self.ranking
    self.group(:item_id).order("count_item_id DESC").limit(10).count(:item_id)
  end
end
