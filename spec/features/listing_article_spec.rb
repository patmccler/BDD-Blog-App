require "rails_helper"

RSpec.feature "Listing Articles", :aggregate_failures do
  before do
    @article1 = Article.create(title: "First Article", body: "Lorem ipsum dolor sit")
    @article2 = Article.create(title: "Second Article", body: "Body of second article")
  end

  scenario "a user lists all articles" do
    visit "/"

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article1.body)

    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end

  scenario "a user has no articles" do
    Article.delete_all
    visit "/"

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article1.body)

    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within ("h1#no-articles") do
      expect(page).to have_content("No Articles Created")
    end
  end
end
