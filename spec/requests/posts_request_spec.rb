require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    @user = create(:user)
  end
  
  describe "ログインした時" do
  
    describe 'GET index' do
      before do
        sign_in(@user)
      end
      it "200httpレスポンスを返す" do
        get posts_path
        expect(response.status).to eq 200
      end
  
      it "indexページが表示される" do
        get posts_path
        expect(response).to render_template :index
      end
    end
    
  end
  
  # ログインしていない時のテスト
  describe "ログインしない時" do
    describe 'GET index' do
      
      it "302httpレスポンスを返す" do
        get posts_path
        expect(response.status).to eq 302
      end
  
      it "userログインページにリダイレクトされる" do
        get posts_path
        expect(response).to redirect_to new_user_session_url
      end
    end
  end
  
end
