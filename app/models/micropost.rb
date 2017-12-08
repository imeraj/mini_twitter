require 'elasticsearch/model'

class Micropost < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

  def as_indexed_json(options={})
    	as_json(
        	include: {user: {except: [:password_digest, :activation_digest, :remember_digest]}}
			)
	end

  class << self
    def search(query)
      __elasticsearch__.search(
        {
          query: {
              match:  { content: query }
          },
          highlight: {
            pre_tags: ['<hi>'],
            post_tags: ['</hi>'],
            fields: {
              content: {}
            }
          }
        }
      )
    end
  end

private
  def picture_size
    if picture.size > 1.megabytes
      errors.add(:picture, "should be less than 1MB")
    end
  end
end
