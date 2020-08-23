require 'gh/user'

module Gh
  module Api
    def self.find_ext_user(ext_user_id)
      return [true, false].sample ? [User.new(ext_user_id), nil] : [nil, "Random network error"] if Rails.env.test?

      [Gh::User.new(ext_user_id), nil]
    end
  end
end
