require_relative 'db_connection'
require 'active_support/inflector'
require_relative 'associatable'
require_relative 'searchable'
require_relative 'associatable2'

class SQLObject
  def self.columns
    return @columns if @columns
    columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    columns = columns[0].map do |column|
      column.to_sym
    end

    @columns = columns
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column.to_sym) do
        self.attributes[column]
      end

      define_method("#{column}=") do |val|
        self.attributes[column] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.to_s.pluralize.tableize
  end

  def self.all
    all = DBConnection.execute(<<-SQL)
    SELECT
      #{self.table_name}.*
    FROM
      #{self.table_name}
    SQL
    parse_all(all)
  end

  def self.first
    first = DBConnection.execute(<<-SQL)
    SELECT
      #{self.table_name}.*
    FROM
      #{self.table_name}
    LIMIT
      1
    SQL
    parse_all(first).first
  end

  def self.last
    last = DBConnection.execute(<<-SQL)
    SELECT
      #{self.table_name}.*
    FROM
      #{self.table_name}
    ORDER BY
      id DESC
    LIMIT
      1
    SQL
    parse_all(last).first
  end

  def self.parse_all(results)
    instances = results.map do |result|
      self.new(result)
    end
    return instances
  end

  def self.find(id)
    one_dog = DBConnection.execute(<<-SQL, id)
    SELECT
      #{self.table_name}.*
    FROM
      #{self.table_name}
    WHERE
      id = ?
    SQL

    parse_all(one_dog).first
  end

  def initialize(params = {})
    params.each do |name, value|
      name = name.to_sym
      if self.class.columns.include?(name)
        self.send("#{name}=", value)
      else
        raise "unknown attribute '#{name}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    @attributes.values
  end

  def insert
    col_names = self.class.columns[1..-1].join(", ")
    question_marks = (["?"] * attribute_values.length).join(", ")
    DBConnection.execute(<<-SQL, *attribute_values)
    INSERT INTO
      #{self.class.table_name} (#{col_names})
    VALUES
      (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    id = self.attributes[:id]
    attr_name = self.class.columns.map do |column|
      "#{column} = ?"
    end
    attr_name = attr_name.join(", ")
    DBConnection.execute(<<-SQL, *attribute_values, id)
    UPDATE
      #{self.class.table_name}
    SET
      #{attr_name}
    WHERE
      id = ?
    SQL
  end

  def save
    if self.attributes[:id].nil?
      self.insert
    else
      self.update
    end
  end
end
