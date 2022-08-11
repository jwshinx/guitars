class StoresSerializer
  def initialize(stores)
    @stores = stores
  end

  def as_json
    stores.map do |store|
      {
        id: store.id,
        name: store.name,
        active: store.active,
        guitars: store.guitars.each_with_object([]) do |guitar, arr|
          arr << {
            id: guitar.id,
            name: guitar.name,
            price: guitar.price,
            quantity: guitar.units.where(store_id: store.id).first&.quantity }
        end
      }
    end
  end

  private

  attr_reader :stores
end