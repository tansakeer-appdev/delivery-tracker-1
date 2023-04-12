# == Schema Information
#
# Table name: packages
#
#  id           :integer          not null, primary key
#  arrival_date :date
#  description  :string
#  details      :text
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#
class Package < ApplicationRecord
  validates :description, :presence => true
  validates :arrival_date, :presence => true


  belongs_to :package_owner, :class_name => "User", :foreign_key => "user_id"

  def timing
    diff = (Date.parse(Time.now.to_s) - Date.parse(self.arrival_date.to_s)).to_i
  end
end
