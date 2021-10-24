require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "index action renders successfully" do
    get articles_url
    assert_response :success
  end

  test "index action returns all the articles" do
    article_count = Article.count
    assert  article_count > 0

    get articles_url
    assert_response :success

    articles = JSON.parse response.body
    assert_equal articles.count, article_count
  end

  test "the create action creates and returns a new article" do
    article_params = {
      title: "Rando Title",
      summary: "Some random summary",
      url: "https://rando.url.something"
    }

    assert_difference("Article.count", +1) do
      post articles_url, params: article_params
      assert_response :success
    end

    article = JSON.parse response.body

    assert(article["id"].present?)
    [:title, :summary, :url].each do |key|
      assert_equal article[key.to_s], article_params[key]
    end
  end

  test "the destroy action deletes and returns an article" do
    article = Article.last
    assert_difference("Article.count", -1) do
      delete article_url article
      assert_response :success
    end

    deleted_article = JSON.parse response.body

    assert(deleted_article["id"].present?)
    [:title, :summary, :url].each do |key|
      assert_equal deleted_article[key.to_s], article[key]
    end
  end
end
