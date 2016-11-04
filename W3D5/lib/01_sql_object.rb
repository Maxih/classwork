require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    if @columns.nil?
      cols = DBConnection.execute2(<<-SQL)
          SELECT
            *
          FROM
            #{self.table_name}
        SQL

      @columns = cols.first.map(&:to_sym)
    end

    @columns
  end

  def self.finalize!
    self.columns.each do |column|
      define_method("#{column}") { self.attributes[column] }
      define_method("#{column}=") { |val| self.attributes[column] = val }
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= name.tableize
    @table_name
  end

  def self.all
    vals = DBConnection.execute(<<-SQL)
        SELECT
          *
        FROM
          #{self.table_name}
      SQL

    self.parse_all(vals)
  end

  def self.parse_all(results)
    results.map { |val| self.new(val) }
  end

  def self.find(id)
    vals = DBConnection.execute(<<-SQL, id)
        SELECT
          *
        FROM
          #{self.table_name}
        WHERE
          id = ?
      SQL

    self.parse_all(vals).first
  end

  def initialize(params = {})
    params.each do |col, val|
      raise "unknown attribute '#{col}'" unless self.class.columns.include? col.to_sym
      self.send("#{col}=", val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |col| self.send("#{col}") }
  end

  def insert
    attr_vals = attribute_values
    vals = (["?"] * attr_vals.count).join(",")

    DBConnection.execute(<<-SQL, *attr_vals)
      INSERT INTO
        #{self.class.table_name} (#{self.class.columns.join(",")})
      VALUES
        (#{vals})
    SQL

    insert_id = DBConnection.last_insert_row_id

    self.send("id=", insert_id)

    insert_id
  end

  def update
    attr_cols = self.class.columns.map { |col| "#{col}=?"}
    attr_vals = attribute_values

    DBConnection.execute(<<-SQL, *attr_vals, self.id)
      UPDATE
        #{self.class.table_name}
      SET
      #{attr_cols.join(",")}
      WHERE id = ?
    SQL

  end

  def save
    self.id ? update : insert
  end
end
