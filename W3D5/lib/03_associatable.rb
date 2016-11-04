require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    self.class_name.constantize
  end

  def table_name
    self.model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})

    self.foreign_key = "#{name.to_s.singularize}_id".to_sym
    self.primary_key = :id
    self.class_name = name.to_s.singularize.camelcase

    options.each do |key, val|
      send("#{key}=", val)
    end

  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})

    self.foreign_key = "#{self_class_name.downcase.singularize}_id".to_sym
    self.primary_key = :id
    self.class_name = name.to_s.singularize.camelcase

    options.each do |key, val|
      send("#{key}=", val)
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})

    options = BelongsToOptions.new(name, options)

    assoc_options[name] = options

    define_method("#{name}") do
      classname = options.model_class

      foreign_val = self.send("#{options.foreign_key}")

      classname.where(options.primary_key.to_s => foreign_val).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.to_s, options)

    define_method("#{name}") do
      classname = options.model_class

      foreign_val = self.send("#{options.primary_key}")

      classname.where(options.foreign_key.to_s => foreign_val)
    end

  end

  def assoc_options
    @assoc_options ||= {}

  end

end

class SQLObject
  extend Associatable
end
