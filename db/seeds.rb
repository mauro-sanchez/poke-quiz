# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

[
  { description: 'Pokémon name', question_type: :name },
  { description: 'Which ability does this pokémon have?', question_type: :ability },
  { description: 'This pokémon evolves to', question_type: :evolves_to },
  { description: 'This pokémon evolves from', question_type: :evolves_from },
  { description: 'Height of this pokémon?', question_type: :height },
  { description: 'Weight of this pokémon', question_type: :weight },
  { description: 'Type of this pokémon?', question_type: :type },
  { description: 'Pokédex flavor text', question_type: :flavor_text },
  { description: 'National Pokédex number', question_type: :pokedex_number },
  { description: 'Pokémon category', question_type: :category }
].each do |question|
  Question.find_or_create_by!(question_type: question[:question_type]) do |new_question|
    new_question.description = question[:description]
  end
end
