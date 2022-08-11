class GuitarSerializer
  def initialize(guitar)
    @guitar = guitar
  end

  def as_json
    {
      id: guitar.id,
      name: guitar.name,
      price: guitar.price,
      stores: guitar.stores.each_with_object([]) do |store, arr|
        arr << {
          id: store.id,
          name: store.name,
          active: store.active,
          quantity: store.units.where(guitar_id: guitar.id).first&.quantity
        }
      end
    }
  end

  private

  attr_reader :guitar
end