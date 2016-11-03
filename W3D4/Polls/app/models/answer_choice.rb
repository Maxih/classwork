# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  text        :string           not null
#  question_id :integer          not null
#

class AnswerChoice < ActiveRecord::Base

  belongs_to :question,
    class_name: 'Question',
    primary_key: :id,
    foreign_key: :question_id

end
