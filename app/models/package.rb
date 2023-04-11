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

  belongs_to :package_owner, :class_name => "User", :foreign_key => "user_id"
end
