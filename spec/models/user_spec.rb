# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  quiz_id    :integer
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  score      :jsonb
#
# Indexes
#
#  index_users_on_quiz_id  (quiz_id)
#
# Foreign Keys
#
#  fk_rails_...  (quiz_id => quizzes.id)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
