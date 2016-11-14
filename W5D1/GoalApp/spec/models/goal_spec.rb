require 'rails_helper'

RSpec.describe Goal, type: :model do

  # subject(:goal) do
  #   Goal.create(body:"goal", completed: true, viewable: tru)
  # end

  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:completed) }
  it { should validate_presence_of(:viewable) }
  it { should validate_presence_of(:user) }

end
