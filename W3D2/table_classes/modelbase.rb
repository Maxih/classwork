class ModelBase
  @@table_name = ''

  def self.find_by_id(id)
    vals = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{@@table_name}
      WHERE
        id = ?
      SQL

    return nil unless vals.length > 0

    self.new(vals.first)
  end

  def self.all
    vals = QuestionDBConnection.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{@@table_name}
      SQL

    return nil unless vals.length > 0

    vals.map { |val| self.new(val) }
  end


  def save
    @id.nil? ? insert : update
  end

  def format_insert
    instance_vars = self.instance_variables - [:@id]
    col_names = instance_vars.map { |var| var[1..-1] }.join(', ')
    col_vals = instance_vars.map {|var| "'#{self.instance_variable_get(var)}'"}.join(',')

    "INSERT INTO #{@@table_name} (#{col_names}) VALUES (#{col_vals})"
  end

  def format_update
    instance_vars = self.instance_variables - [:@id]
    col_vals = instance_vars.map {|var| "#{var[1..-1]}='#{self.instance_variable_get(var)}'"}.join(',')

    "UPDATE #{@@table_name} SET #{col_vals} WHERE id=#{@id}"
  end


  def insert
    QuestionDBConnection.instance.execute(format_insert)
    @id = QuestionDBConnection.instance.last_insert_row_id
  end

  def update
    QuestionDBConnection.instance.execute(format_update)
  end

end
