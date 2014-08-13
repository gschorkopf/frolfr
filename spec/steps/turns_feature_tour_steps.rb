step "there is a two-hole course" do
  @course = FactoryGirl.create(:course)
  1.upto(2) do |i|
    FactoryGirl.create(:hole, course: @course, number: i)
  end
end

step "I've started a round on the two-hole course" do
  @round = FactoryGirl.create(:round, course: @course)
  @scorecard = FactoryGirl.create(:scorecard, round: @round, user: @user)
  @course.holes.each do |hole|
    FactoryGirl.create(:turn, hole: hole, scorecard: @scorecard)
  end
end

step "I navigate to hole one" do
  visit turn_path(Turn.first)
end

step "I take three shots" do
  select "3", from: :turn_score
end

step "I should see my total is three" do
  within(".total") do
    expect(page).to have_content "3"
  end
end

step "I navigate to hole two" do
  find("[rel~='next-turn']").click
end

step "I update the par to four" do
  choose("Four")
end

step "I should see my total is six" do
  within(".total") do
    expect(page).to have_content "6"
  end
end

step "I should see my shooting is minus one" do
  within(".total") do
    expect(page).to have_content "-1"
  end
end

step "I navigate to the recap" do
  page.click_on I18n.t('round.recap')
end

step "I should see my recap" do
  expect(page).to have_content @course.name
  expect(page).to have_content "6"
end

