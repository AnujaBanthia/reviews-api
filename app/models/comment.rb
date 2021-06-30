class Comment < ApplicationRecord
  validates :content, presence: true,
                      length: { minimum: 1, maximum: 200 }
  belongs_to :user
  belongs_to :review

  def as_json(_options = {})
    super(only: %i[id
                   content], include: [review: { reviewable: { except: %i[user_id created_at updated_at] },
                                                 except: %i[user_id created_at
                                                            updated_at] }, user: { only: %i[id email] }])
  end
end
