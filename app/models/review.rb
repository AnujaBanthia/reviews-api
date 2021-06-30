class Review < ApplicationRecord
    validates :content, presence: true,
                        length: { minimum: 1, maximum: 200 }
    belongs_to :reviewable, polymorphic: true
    belongs_to :user
    has_many :comments

    def as_json(options={})
        super(only: [:id,:content], include: [ :reviewable => {except: [:user_id, :created_at, :updated_at]}, :user => { only: [:id, :email] }  ] )
      end
end
