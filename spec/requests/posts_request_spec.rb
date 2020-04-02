require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    @user = create(:user)
    @post = create(:post)
  end

  describe "ログインした時" do

    before do
      sign_in(@user)
    end

    describe 'GET index' do
      it "200httpレスポンスを返す" do
        get posts_path
        expect(response.status).to eq 200
      end

      it "indexページが表示される" do
        get posts_path
        expect(response).to render_template :index
      end
    end


    describe 'GET show' do
      it "200httpレスポンスを返す" do
        get post_path(@post)
        expect(response.status).to eq 200
      end

      it "indexページが表示される" do
        get post_path(@post)
        expect(response).to render_template :show
      end
    end
    
    describe 'POST create' do
      context 'パラメータが妥当な場合' do
        it "リクエストが成功すること" do
          post posts_path, params: { post: FactoryBot.attributes_for(:post) }
          expect(response.status).to eq 302
        end
  
        it '投稿が登録されること' do
          expect do
            post posts_path, params: { post: FactoryBot.attributes_for(:post) }
          end.to change(Post, :count).by(1)
        end
        
        it 'リダイレクトすること' do
          post posts_path, params: { post: FactoryBot.attributes_for(:post) }
          expect(response).to redirect_to Post.last
        end
      end
      
      context 'パラメータが不正な場合' do
        it '200レスポンスが返却されること' do
          post posts_path, params: { post: FactoryBot.attributes_for(:post, :invalid) }
          expect(response.status).to eq 200
        end
  
        it '投稿が登録されないこと' do
          expect do
            post posts_path, params: { post: FactoryBot.attributes_for(:post, :invalid) }
          end.to_not change(Post, :count)
        end
  
        it 'エラーが表示されること' do
          post posts_path, params: { post: FactoryBot.attributes_for(:post, :invalid) }
          expect(response.body).to include 'prohibited this post from being saved'
        end
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

    describe 'GET show' do

      it "302httpレスポンスを返す" do
        get post_path(@user)
        expect(response.status).to eq 302
      end

      it "userログインページにリダイレクトされる" do
        get post_path(@user)
        expect(response).to redirect_to new_user_session_url
      end
    end
    
    describe 'Post create' do

      it "リダイレクトすること" do
        post posts_path, params: { post: FactoryBot.attributes_for(:post) }
        expect(response.status).to eq 302
      end

      it '投稿が登録されないこと' do
        expect do
          post posts_path, params: { post: FactoryBot.attributes_for(:post) }
        end.to_not change(Post, :count)
      end
      
      it "userログインページにリダイレクトされる" do
        post posts_path, params: { post: FactoryBot.attributes_for(:post) }
        expect(response).to redirect_to new_user_session_url
      end

    end
    
  end

end
