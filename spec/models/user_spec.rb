require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
  end
  
  describe 'バリデーション' do
    it 'emailとpasswordどちらも値が設定されていれば、OK' do
      expect(@user.valid?).to eq(true)
    end

    it 'emailが空だとNG' do
      @user.email = ''
      expect(@user.valid?).to eq(false)
    end

    it 'passwordが空だとNG' do
      @user.password = ''
      expect(@user.valid?).to eq(false)
    end
  end
end
