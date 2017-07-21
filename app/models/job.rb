class Job < ApplicationRecord
  before_validation :generate_friendly_id, :on => :create

  validates_presence_of :friendly_id

  def to_param
    self.friendly_id
  end

  validates :title, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0}
  validates :wage_upper_bound, numericality: { greater_than: :wage_lower_bound }

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  scope :published, -> {where(:is_hidden => false)}
  scope :recent, -> {order('created_at DESC')}
  scope :lower_wage, -> {order('wage_lower_bound DESC')}
  scope :upper_wage, -> {order('wage_upper_bound DESC')}

  has_many :resumes
  belongs_to :user

  has_many :favorites
  has_many :fans, through: :favorites, source: :user

  has_many :job_relationships, dependent: :destroy
  has_many :applicants, through: :job_relationships, source: :user

  protected

  def generate_friendly_id
    self.friendly_id ||= SecureRandom.uuid
  end



end
