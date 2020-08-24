module Pb
  module Api
    def self.get_user_balance(user_id)
      return [true, false].sample ? [rand(0..1000000), nil] : [nil, "Random network error"] if Rails.env.test?

      [rand(1000..1000000), nil]
    end

    def self.redeem(source_id, points)
      return [true, false].sample ? [source_id, nil] : [nil, "Random network error"] if Rails.env.test?

      [source_id, nil]
    end
  end
end
