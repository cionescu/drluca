raise "Don't run this outside dev" unless Rails.env.development?

Question.delete_all
Quiz.delete_all
User.delete_all

Question.create!(title: "Care este numele de mijloc al lui B. P. Hasdeu?", answer: "Petriceicu", incorrect_answers: ['Petre', 'Pretrisceiu', 'Paul'])
Question.create!(title: "Care este numele mic al compositorului Puccini?", answer: "Giacomo", incorrect_answers: ['Gianluca', 'Gioachino', 'Giovanni'])

quiz = Quiz.create!(name: "Grupa 2+")

user1 = User.create!(name: "Catalin", quiz: quiz)
user2 = User.create!(name: "Luiza", quiz: quiz)
