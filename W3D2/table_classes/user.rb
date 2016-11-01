class User < ModelBase

  @@table_name = 'users'

  def self.find_by_name(fname, lname)
    user = QuestionDBConnection.instance.execute(<<-SQL, @@table_name, fname, lname)
      SELECT
        *
      FROM
        ?
      WHERE
        fname = ? AND lname = ?
      SQL

      return nil unless user.length > 0

      User.new(user.first)
  end

  attr_accessor :fname, :lname

  def initialize(options)

    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']

  end

  def authored_questions

    questions = QuestionDBConnection.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        questions
      WHERE
        author = ?
      SQL

    questions.map { |question| Question.new(question) }

  end


  def authored_replies

    replies = QuestionDBConnection.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        user = ?
      SQL

    replies.map { |reply| Reply.new(reply) }

  end

  def followed_question
    QuestionFollows.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLikes.liked_questions_for_user_id(@id)
  end

  def average_karma
    replies = QuestionDBConnection.instance.execute(<<-SQL, @id)
      SELECT
        AVG(sub.count)
      FROM
        (SELECT
          COUNT(*) AS count
        FROM
          questions
        JOIN
          question_likes ON question_likes.question = questions.id
        WHERE
          questions.author = 1
        GROUP BY
          question_likes.question) AS sub

      SQL

    replies.first
  end

  def save
    @id.nil? ? insert : update
  end

  def insert
    QuestionDBConnection.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
    SQL
    @id = QuestionDBConnection.instance.last_insert_row_id
  end

  def update
    QuestionDBConnection.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
    SQL
  end

end
