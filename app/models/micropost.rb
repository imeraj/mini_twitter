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
        include: {
                  user: {methods: [:followers_ids], only: [:id, :name, :email]},
                }
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


# Delete the previous Microposts index in Elasticsearch
Micropost.__elasticsearch__.client.indices.delete index: Micropost.index_name rescue nil

# Create the new index with the new mapping
Micropost.__elasticsearch__.client.indices.create \
  index: Micropost.index_name,
  body: { settings: Micropost.settings.to_hash, mappings: Micropost.mappings.to_hash }

Micropost.__elasticsearch__.import
