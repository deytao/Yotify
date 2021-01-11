class Wallet < ApplicationRecord
  belongs_to :company
  belongs_to :portfolio
end
