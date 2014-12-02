class ScorecardSerializer < ActiveModel::Serializer
  embed :ids, include: true
  has_many :turns
  attributes :id, :user_id, :round_id, :user_initials, :turn_ids,
             :created_at, :course_name

  def created_at
    object.round.created_at
  end

  def course_name
    object.round.course.name
  end

  def turn_ids
    object.turns.pluck(:id)
  end

  def user_initials
    names.map { |name| name.chars.first }.join
  end

  private

  def user
    object.user
  end

  def names
    [user.first_name, user.middle_name, user.last_name].compact
  end
end
