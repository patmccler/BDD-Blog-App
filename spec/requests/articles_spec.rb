require "rails_helper"

RSpec.describe "Articles", type: :request do
  before do
    @article = Article.create(title: "Article 1", body: "Body of article one")
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
