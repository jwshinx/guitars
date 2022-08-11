class StoreSerializer
  def initialize(store)
    @store = store
  end

  def as_json
    {
      id: store.id,
      name: store.name,
      active: store.active
    }
  end

  private

  attr_reader :store
end