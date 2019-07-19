class Album < ApplicationRecord
    belongs_to :user
    has_many :photos, as: :photoable
    paginates_per 40



end
