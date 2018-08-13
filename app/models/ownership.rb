class Ownership < ApplicationRecord
  belongs_to :user
  belongs_to :item

  OWNERSHIP_OPTIONS = %w(Want Have)
end
