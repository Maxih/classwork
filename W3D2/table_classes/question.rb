
class Question < ModelBase

  @@table_name = 'questions'

  def self.find_by_author_id(author_id)
    question = QuestionDBConnection.instance.execute(<<-SQL, @@table_name, author_id)
      SELECT
        *
      FROM
        ?
      WHERE
        author = ?
      SQL

      return nil unless question.length > 0

      Question.new(question.first)
  end

  def self.most_followed(n)
    QuestionFollows.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLikes.most_liked_questions(n)
  end

  attr_accessor :title, :body, :author

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author = options['author']
  end

  def author
    user = QuestionDBConnection.instance.execute(<<-SQL, @author)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
      SQL

      return nil unless user.length > 0

      User.new(user.first)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollows.followers_for_question_id(@id)
  end

  def likers
    QuestionsLikes.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLikes.num_likes_for_question_id(@id)
  end
end
