# == Schema Information
#
# Table name: questions
#
#  id                :bigint(8)        not null, primary key
#  title             :string
#  url               :string
#  incorrect_answers :jsonb
#  answer            :string
#  autogenerated     :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  category          :integer          default("general")
#

class Question < ApplicationRecord
  enum category: {
    general: 0,
    capitals: 1,
    flags: 2,
    painter: 3,
    art_work: 4,
    surgical_tools: 5
  }
end
