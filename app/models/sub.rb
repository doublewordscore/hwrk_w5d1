# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :string           not null
#  moderator_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true

  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id
  )

  has_many(
    :post_subs,
    class_name: "PostSub",
    foreign_key: :sub_id,
    primary_key: :id,
    inverse_of: :sub
  )

  has_many(
    :posts,
    through: :post_subs,
    source: :post
  )

end
