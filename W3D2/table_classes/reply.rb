
class Reply < ModelBase

  @@table_name = 'replies'

  def self.find_by_user_id(user_id)
    replies = QuestionDBConnection.instance.execute(<<-SQL, @@table_name, user_id)
      SELECT
        *
      FROM
        ?
      WHERE
        user = ?
      SQL

      return nil unless replies.length > 0

      replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    replies = QuestionDBConnection.instance.execute(<<-SQL, @@table_name, question_id)
      SELECT
        *
      FROM
        ?
      WHERE
        question = ?
      SQL

      return nil unless replies.length > 0

      replies.map { |reply| Reply.new(reply) }
  end

  attr_accessor :question, :parent, :user, :body

  def initialize(options)
    @id = options['id']
    @question = options['question']
    @parent = options['parent']
    @user = options['user']
    @body = options['body']

  end

  def author
    User.find_by_id(@user)
  end

  def question
    Question.find_by_id(@question)
  end

  def parent_reply
    return nil if @parent.nil?
    Reply.find_by_id(@parent)
  end

  def child_replies
    replies = QuestionDBConnection.instance.execute(<<-SQL, @@table_name, @id)
      SELECT
        *
      FROM
        ?
      WHERE
        parent = ?
      SQL

    return nil unless replies.length > 0

    replies.map { |reply| Reply.new(reply) }
  end

end
