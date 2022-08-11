class StoreSerializer
  def initialize(store)
    @store = store
  end

  def as_json
    {
      id: store.id,
      name: store.name,
      active: store.active,
      guitars: store.guitars.each_with_object([]) do |guitar, arr|
        arr << { 
          id: guitar.id,
          name: guitar.name,
          price: guitar.price,
          quantity: guitar.units.where(store_id: store.id).first&.quantity
        }
      end
    }
  end

  private

  attr_reader :store
end