module Jsonplaceholder
  class Owner < Base
    # attr_accessor :name, :id

    CACHE_DEFAULTS = { expires_in: 7.days, force: false }

    def self.random(query = {}, clear_cache, store_id)
      cache = CACHE_DEFAULTS.merge({ force: clear_cache })
      user_id = store_id % 10
      response = Request.where("users/#{user_id}", cache, query)
      [response['name'], response[:errors]]
    end

    def self.find(id)
      response = Request.get("users/1", CACHE_DEFAULTS)
      Owner.new(response)
    end

    def initialize(args = {})
      super(args)
    end
  end
end
