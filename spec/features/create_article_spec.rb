require "rails_helper"

RSpec.feature "Creating Articles" do
  scenario "A user creates a new article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: "Creating a blog"
    fill_in "Body", with: "Lorem Ipsum"

    click_button "Create Article"

    expect(page).to have_content("Article has neen created")
    expect(page.current_path).to eq(atricles_path)
  end
end
