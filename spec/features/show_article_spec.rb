require "rails_helper"

RSpec.feature "Creating Articles" do
  before do
    @john = User.create!(email: "john@exmaple.com", password: "password")
    @bob = User.create!(email: "bob@exmaple.com", password: "pword123")

    @article = Article.create(title: "First Article", body: "Once upon a time...", user: @john)
  end

  scenario "to non-signed in user, hide edit and delete buttons" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")

    expect(current_path).to eq("/articles/#{@article.id}")
  end

  scenario "non-owner user, hide edit and delete buttons" do
    login_as(@bob)
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")

    expect(current_path).to eq("/articles/#{@article.id}")
  end

  scenario "owner user, hide edit and delete buttons" do
    login_as(@john)
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")

    expect(current_path).to eq("/articles/#{@article.id}")
  end
end
