json.array! @quizzes do |quiz|
  json.user quiz.user.username
  json.score quiz.score
  json.created_at quiz.created_at
end
