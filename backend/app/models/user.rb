class User < ApplicationRecord
  attribute :enabled, :boolean, default: true
end
