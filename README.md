# stORM

stORM is a light object-relational mapping (ORM) framework.  stORM was written in Ruby and heavily inspired by Ruby on Rails.  It can use Ruby methods and objects to manipulate the database through a very simple interface.  Objects are a record in the database and relationships between the objects can be referred through associations.

## Demo

The `dog.rb` file sets up three models (`Dog`, `Human` and a `House`).  The file also sets up the necessary associations.  The database has been seeded using the `dogs.sql` file.  Some setup is required to test out the demo.

### Setup

1. Download the library and navigate to the root directory of the file.
2. Open pry and load the dog.rb file by typing load 'dog.rb'.
3. Start testing!

### Database Manipulation and Querying

#### `::all`

Returns an array of Ruby objects that belong to that specific class.

#### `::find(id)`

Returns a Ruby object with the corresponding `id`.  Returns `nil` if record does not exist.

#### `#initialize(params = {})`

Return a Ruby object with the params provided.  The params should be provided in a key-value pair the key is a column name and the value is the value for the new object under that specific column name.  ie. `{name: "Martin"}`, `:name` is the column name and "Martin" is the value.  If a column name is provided and does not exist on the table, then an error will be raised.

#### `#save`

Saves or updates the new record to the database.

#### `where(params)`

Return an array of Ruby objects that satisfy the provided params.

#### `belongs_to(name, options = {})`

The class with the `belongs_to` association usually contains a foreign key that references another Ruby object.  This is a one-to-one relation and this method defines an instance method on the name that is passed in through the params.  The associated model is returned.

#### Options

`:class_name`

The class name option should either be a symbol or string.  The name provided in the parameter is used and converted to `CamelCase` and singularized.  If the name provided was dog, then the class name would be Dog.

`:foreign_key`

The foreign key option should either be a symbol or string.  The name provided in the parameter is used and converted to `snake_case` and `_id` is appended to the end.  If the name provided was dog, then the foreign key would be dog_id.

`:primary_key`

The primary key option should either be a symbol or string.  The primary key will most likely always be set to `id`.

#### `has_many(name, options = {})`

The class with the `has_many` association usually does not contain a foreign key.  This is a one-to-many relation and this method defines an instance method on the name that is passed in through the params.  The associated models are returned in an array.

`:class_name`

The class name option should either be a symbol or string.  The name provided in the parameter is used and converted to `CamelCase` and singularized.  If the name provided was dog, then the class name would be Dog.

`:foreign_key`

The foreign key option should either be a symbol or string.  The name provided in the parameter is used and converted to `snake_case` and `_id` is appended to the end.  If the name provided was dog, then the foreign key would be dog_id.

`:primary_key`

The primary key option should either be a symbol or string.  The primary key will most likely always be set to `id`.

#### `has_one_through(name, through_name, source_name)`

This association is a one-to-one relationship where the current model reaches through an already existing association to create a new association.  
