class Room < ActiveRecord::Base
  belongs_to :user

  def complete_name
    "#{title}, #{location}"
  end
end
