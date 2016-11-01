class QuestionLike

  def self.likers_for_question_id(question_id)
    likers = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_likes
      JOIN
        users ON users.id = question_likes.user
      WHERE
        question_likes.question = ?
      SQL

    return nil unless likers.length > 0

    likers.map { |liker| User.new(liker) }
  end

  def self.num_likes_for_question_id(question_id)
    likers = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(users.*)
      FROM
        question_likes
      JOIN
        users ON users.id = question_likes.user
      WHERE
        question_likes.question = ?
      SQL

    return nil unless likers.length > 0

    likers.first
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON questions.id = question_likes.question
      WHERE
        question_likes.user = ?
      SQL

    questions.map { |question| Question.new(question) }

  end

  def self.most_liked_questions(n)
    questions = QuestionDBConnection.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON questions.id = question_likes.question
      GROUP BY
        question_likes.question
      ORDER BY
        COUNT(question_likes.question) DESC
      LIMIT ?

      SQL

    return nil unless questions.length > 0

    questions.map { |question| Question.new(question) }
  end

end
