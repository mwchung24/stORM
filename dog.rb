require_relative 'map'

class Dog < SQLObject
  belongs_to :owner,
    class_name: 'Human'

  has_one_through :home, :owner, :house

  finalize!
end

class Human  < SQLObject
  self.table_name = 'humans'

  belongs_to :house

  has_many :dogs,
    foreign_key: :owner_id

  finalize!
end

class House  < SQLObject
  has_many :residents,
    class_name: 'Human'

  finalize!
end
