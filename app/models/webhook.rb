class Webhook < ApplicationRecord
  validates :payload, presence: true
end
