class QuestionFollows

  def self.followers_for_question_id(question_id)
    followers = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_follows
      JOIN
        users ON users.id = question_follows.user
      WHERE
        question_follows.question = ?
      SQL

    return nil unless followers.length > 0

    followers.map { |follower| User.new(follower) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_follows
      JOIN
        questions ON questions.id = question_follows.question
      WHERE
        question_follows.user = ?
      SQL

    return nil unless questions.length > 0

    questions.map { |question| Question.new(question) }
  end

  def self.most_followed_questions(n)
    questions = QuestionDBConnection.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_follows
      JOIN
        questions ON questions.id = question_follows.question
      GROUP BY
        question_follows.question
      ORDER BY
        COUNT(question_follows.question) DESC
      LIMIT ?

      SQL

    return nil unless questions.length > 0

    questions.map { |question| Question.new(question) }
  end
end
