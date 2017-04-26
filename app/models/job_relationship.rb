class JobRelationship < ApplicationRecord
  belongs_to :uesr
  belongs_to :job
end
