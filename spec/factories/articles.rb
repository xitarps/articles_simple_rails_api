FactoryBot.define do
  factory :article do
    title { "Sample article" }
    content { "Sample content" }
    sequence(:slug) { |slug| "slug_n#{slug}" }
  end
end
