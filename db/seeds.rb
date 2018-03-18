User.delete_all
Question.delete_all
Quiz.delete_all

Question.create!(title: "Care este numele de mijloc al lui B. P. Hasdeu?", answer: "Petriceicu", incorrect_answers: ['Petre', 'Pretrisceiu', 'Paul'])
Question.create!(title: "Care este numele mic al compositorului Puccini?", answer: "Giacomo", incorrect_answers: ['Gianluca', 'Gioachino', 'Giovanni'])
Question.create!(title: "Care este capitala Statelor Unite ale Americii?", answer: "Washington D.C.", incorrect_answers: ['New York', 'Los Angeles', 'Philadelphia'])
Question.create!(title: "Cine a scris romanul 'Padurea Spanzuratilor'?", answer: "Liviu Rebreanu", incorrect_answers: ['Ion Creanga', 'George Calinescu', 'Mihai Eminescu'])

quiz = Quiz.create!(name: "Grupa 2+", questions: Question.pluck(:id))

user1 = User.create!(name: "Catalin", quiz: quiz)
user2 = User.create!(name: "Luiza", quiz: quiz)
