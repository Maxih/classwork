# == Schema Information
#
# Table name: polls
#
#  id     :integer          not null, primary key
#  title  :string           not null
#  author :integer          not null
#

class Poll < ActiveRecord::Base
  validates :title, presence: true

  has_many: :question_answers
    through: :answers

  has_many :questions,
    class_name: 'Question',
    primary_key: :id,
    foreign_key: :poll_id


  belongs_to :author,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :author

end
