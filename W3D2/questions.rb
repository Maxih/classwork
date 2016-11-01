require 'sqlite3'
require 'singleton'

require_relative './table_classes/modelbase'
require_relative './table_classes/question'
require_relative './table_classes/questionfollows'
require_relative './table_classes/reply'
require_relative './table_classes/user'


class QuestionDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end
