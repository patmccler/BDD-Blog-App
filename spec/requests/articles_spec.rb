require "rails_helper"

RSpec.describe "Articles", type: :request do
  before do
    @john = User.create!(email: "john@exmaple.com", password: "password")
    @bob = User.create!(email: "bob@exmaple.com", password: "pword123")
    @article = Article.create!(title: "Article 1", body: "Body of article one", user: @john)
  end

  describe "GET /article/:id/edit" do
    context "with non signed in user" do
      before { get "/articles/#{@article.id}/edit" }

      it "redirects to the sign in page" do
        expect(response.status).to eq(302)
        message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq message
      end
    end

    context "with signed in user who is non owner" do
      before do
        login_as(@bob)
        get "/articles/#{@article.id}/edit"
      end

      it "redirect to home page" do
        expect(response.status).to eq(302)
        message = "You can only edit your own articles."
        expect(flash[:alert]).to eq message
      end
    end

    context "with signed in user who is owner" do
      before do
        login_as(@john)
        get "/articles/#{@article.id}/edit"
      end

      it "successfully edits article" do
        expect(response.status).to eq(200)
      end
    end
  end

  describe "GET /article/:id/edit" do
    context "with non signed in user" do
      before { delete "/articles/#{@article.id}" }

      it "redirects to the sign in page" do
        expect(response.status).to eq(302)
        message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq message
      end
    end

    context "with signed in user who is non owner" do
      before do
        login_as(@bob)
        delete "/articles/#{@article.id}"
      end

      it "redirect to home page" do
        expect(response.status).to eq(302)
        message = "You can only delete your own articles."
        expect(flash[:alert]).to eq message
      end
    end

    context "with signed in user who is owner" do
      before do
        login_as(@john)
        delete "/articles/#{@article.id}"
      end

      it "successfully deletes article" do
        expect(response.status).to eq(200)
      end
    end
  end

  describe "GET /article/id" do
    context "with existing article" do
      before { get "/articles/#{@article.id}" }

      it "handles existing articles" do
        expect(response.status).to eq 200
      end
    end

    context "with nonexiting article" do
      before { get "/articles/XXXX" }

      it "handles non-existing article" do
        expect(response.status).to eq(302)
        flash_message = "The article you are looking for could not be found"

        expect(flash[:alert]).to eq(flash_message)
      end
    end
  end
end
