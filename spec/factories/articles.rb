FactoryBot.define do
  factory :article do
    sequence(:title) { |title_number| "Sample article n#{title_number}" }
    content { "Sample content" }
    sequence(:slug) { |slug_number| "slug_n#{slug_number}" }
  end
end
