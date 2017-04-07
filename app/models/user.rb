class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  has_many :user_provider,        dependent: :destroy
  has_many :created_events,       class_name: 'Event',
           foreign_key: :creator_id,
           dependent: :destroy
  has_many :attendance_relations, foreign_key: 'attendee_id',
           dependent: :destroy
  has_many :attended_events,      through: :attendance_relations

  acts_as_commontator

  # Attend an event
  def attend_event(event)
    attended_events << event
  end

  # UnAttend an event
  def unattend_event(event)
    attended_events.delete(event)
  end

  # Returns true if the current user is following an event
  def attending?(event)
    attended_events.include?(event)
  end

  protected
  def confirmation_required?
    false
  end
end
