module Rankable
  extend ActiveSupport::Concern

  module ClassMethods
    def ranking
      group(:item_id).order("count_item_id DESC").limit(10).count(:item_id)
    end
  end
end
