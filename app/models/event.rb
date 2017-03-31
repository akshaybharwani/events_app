class Event < ApplicationRecord

  filterrific :available_filters => %w[
                search_query
                with_event_category_id
                with_start_date
              ]

  # default for will_paginate
  self.per_page = 10

  belongs_to :creator, class_name: 'User'
  default_scope -> { order(attendee_count: :desc, created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :creator_id, presence: true
  validates :title, presence: true#, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 100 }
  validates :start_date, presence: true
  validate  :picture_size
  has_many :attendance_relations, foreign_key: 'attended_event_id',
           dependent: :destroy
  has_many :attendees,            through: :attendance_relations
  belongs_to :event_category
  private

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 1
    where(
        terms.map {
          or_clauses = [
              'LOWER(events.title) LIKE ?'
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :with_event_category_id, lambda { |event_category_ids|
    where(:event_category_id => [*event_category_ids])
  }
  scope :with_start_date, lambda { |ref_date|
    where('events.start_date = ?', ref_date)
  }

  def decorated_start_date_at
    start_date.to_date.to_s(:long)
  end


  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
