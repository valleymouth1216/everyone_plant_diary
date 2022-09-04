class Favorite < ApplicationRecord

  belongs_to :customer
  belongs_to :diary_date

end
