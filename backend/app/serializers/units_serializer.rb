class UnitsSerializer
  def initialize(units)
    @units = units
  end

  def as_json
    units.map do |unit|
      {
        id: unit.id,
        guitar_name: unit.guitar.name,
        store_name: unit.store.name
      }
    end
  end

  private

  attr_reader :units
end