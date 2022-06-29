require "rails_helper"

RSpec.feature "Editing an article" do
  before do
    @john = User.create!(email: "john@exmaple.com", password: "password")
    login_as(@john)
    @article = Article.create(title: "First Article", body: "Once upon a time...", user: @john)
  end

  scenario "A user updates an article" do
    visit "/"

    click_link @article.title

    click_link "Edit"

    fill_in "Title", with: "Updated Title"
    fill_in "Body", with: "Updated Body"

    click_button "Update Article"

    expect(page).to have_content("Article has been updated")
    expect(current_path).to eq(article_path(@article))
  end

  scenario "A user fails to update an article" do
    visit "/"

    click_link @article.title

    click_link "Edit"

    fill_in "Title", with: ""
    fill_in "Body", with: "Updated Body"

    click_button "Update Article"

    expect(page).to have_content("Article has not been updated")
    expect(current_path).to eq(article_path(@article))
  end
end
