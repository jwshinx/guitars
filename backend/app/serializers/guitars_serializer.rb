class GuitarsSerializer
  def initialize(guitars)
    @guitars = guitars
  end

  def as_json
    guitars.map do |guitar|
      {
        id: guitar.id,
        name: guitar.name,
        price: guitar.price
      }
    end
  end

  private

  attr_reader :guitars
end