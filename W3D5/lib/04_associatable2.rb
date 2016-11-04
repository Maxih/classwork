require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)

    define_method("#{name}") do
      through_options = self.class.assoc_options[through_name]
      

      source_options = BelongsToOptions.new(source_name)

      through_table = through_options.model_class.table_name
      source_table = source_options.model_class.table_name


      p source_options
      p through_options

      vals = DBConnection.execute(<<-SQL,id)

        SELECT
          #{source_table}.*
        FROM
          #{through_table}
        JOIN
          #{source_table} ON #{through_table}.#{through_options.foreign_key}=#{source_table}.#{source_options.primary_key}
        WHERE
          #{through_table}.#{through_options.primary_key}=?
        SQL

        p self.parse_all(vals)
      end
    end
    #  = BelongsToOptions.new(through_name)
    # source_options = BelongsToOptions.new(source_name)
    #

    #
    # p through_table
    # p source_table
    #
    #
    # p name #home
    # p through_name #human
    # p source_name #house
    # p self  #Cat



    #

end
