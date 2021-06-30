class Movie < ApplicationRecord
    validates :title, presence: true,
                      length: { minimum: 1, maximum: 50 }
    validates :director, length: { maximum: 50 }
    validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
    belongs_to :user
    has_many :reviews, as: :reviewable

    def as_json(options={})
      super(only: [:id,:title, :director,:rating], include: { user: { only: [:id, :email] }} )
    end

  end