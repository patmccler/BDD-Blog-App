require "rails_helper"

RSpec.feature "Creating Articles" do
  before do
    @article = Article.create(title: "First Article", body: "Once upon a time...")
  end

  scenario "A user views an article" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)

    expect(current_path).to eq("/articles/#{@article.id}")
  end
end
