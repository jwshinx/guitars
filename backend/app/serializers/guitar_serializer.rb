class GuitarSerializer
  def initialize(guitar)
    @guitar = guitar
  end

  def as_json
    {
      id: guitar.id,
      name: guitar.name,
      price: guitar.price
    }
  end

  private

  attr_reader :guitar
end