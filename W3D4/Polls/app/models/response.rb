# == Schema Information
#
# Table name: responses
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  answer_id   :integer          not null
#  question_id :integer          not null
#

class Response < ActiveRecord::Base

  belongs_to :user,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id

  belongs_to :answer
    class_name: 'AnswerChoice',
    primary_key: :id,
    foreign_key: :answer_id

  belongs_to :question
    class_name: 'Question',
    primary_key: :id,
    foreign_key: :question_id

end
