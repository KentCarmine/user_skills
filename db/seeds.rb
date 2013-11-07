require 'faker'

# create a few users
User.create :name => 'Dev Bootcamp Student', :email => 'me@example.com', :password => 'password'
5.times do
  User.create :name => Faker::Name.name, :email => Faker::Internet.email, :password => 'password'
end

# create a few technical skills
computer_skills = %w(Ruby Sinatra Rails JavaScript jQuery HTML CSS)
computer_skills.each do |skill|
  Skill.create :name => skill, :context => 'technical'
end

# create a few creative skills
design_skills = %w(Photoshop Illustrator Responsive-Design)
design_skills.each do |skill|
  Skill.create :name => skill, :context => 'creative'
end

# TODO: create associations between users and skills

User.all.each do |user|
  computer_skill_choice = rand(0..6)
  random_computer_skill = Skill.find_by_name(computer_skills[computer_skill_choice])

  user_comp_skill = UsersSkill.new(:years_experience => 5, :formally_educated => true)
  user.users_skills << user_comp_skill
  random_computer_skill.users_skills << user_comp_skill

  design_skill_choice = rand(0..2)
  random_design_skill = Skill.find_by_name(design_skills[design_skill_choice])
  user_design_skill = UsersSkill.new(:years_experience => 3, :formally_educated => false)

  user.users_skills << user_design_skill
  random_design_skill.users_skills << user_design_skill

  user.save
end
