Fabricator(:review) do
  rating { (1..5).to_a.sample }
  review_text { Faker::Lorem.paragraphs(2) }
  video
  user
end 