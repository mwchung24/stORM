# stORM

stORM is a light object-relational mapping (ORM) framework.  stORM was written in Ruby and heavily inspired by Ruby on Rails.  It can use Ruby methods and objects to manipulate the database through a very simple interface.  Objects are a record in the database and relationships between the objects can be referred through associations.

## Demo

The `dog.rb` file sets up three models (`Dog`, `Human` and a `House`).  The file also sets up the necessary associations.  The database has been seeded using the `dogs.sql` file.  Some setup is required to test out the demo.

### Setup

1. Download the library and navigate to the root directory of the file.
2. Open pry and load the dog.rb file by typing load 'dog.rb'.
3. Start testing!

### Database Manipulation and Querying

### `::all`

Returns an array of Ruby objects that belong to that specific class.

### `::find(id)`

Returns a Ruby object with the corresponding `id`.  Returns `nil` if record does not exist.
