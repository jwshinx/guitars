class StoresSerializer
  def initialize(stores)
    @stores = stores
  end

  def as_json
    stores.map do |store|
      {
        id: store.id,
        name: store.name,
        active: store.active
      }
    end
  end

  private

  attr_reader :stores
end