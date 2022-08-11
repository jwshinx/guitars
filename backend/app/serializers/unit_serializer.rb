class UnitSerializer
  def initialize(unit)
    @unit = unit
  end

  def as_json
    {
      id: unit.id,
      guitar: {
        name: unit.guitar.name,
        price: unit.guitar.price
      },
      store: {
        name: unit.store.name,
        active: unit.store.active
      }
    }
  end

  private

  attr_reader :unit
end