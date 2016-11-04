require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)

    cols = params.keys.map { |col| "#{col} = ?"}.join(' AND ')

    vals = DBConnection.execute(<<-SQL, *params.values)

    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      #{cols}
    SQL

    self.parse_all(vals)
  end
end

class SQLObject
  extend Searchable


end
