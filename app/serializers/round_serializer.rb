class RoundSerializer < ActiveModel::Serializer
  embed :ids, include: true
  has_many :scorecards
  attributes :id, :course_name, :created_at, :marked_complete, :scorecard_ids, :course_id

  def course_name
    object.course.name
  end

  def course_id
    object.course.id
  end

  def scorecard_ids
    object.scorecards.pluck(:id)
  end
end
