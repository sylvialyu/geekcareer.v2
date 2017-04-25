class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    is_admin
  end

  has_many :resumes
  has_many :jobs
  has_many :favorites
  has_many :favorite_jobs, through: :favorites, source: :job

  validates :email, presence: true
  validates :password, presence: true

  def is_favorite_of?(job)
    favorite_jobs.include?(job)
  end

end
