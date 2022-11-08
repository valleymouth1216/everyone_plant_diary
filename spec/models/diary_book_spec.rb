# frozen_string_literal: true

require 'rails_helper'

require 'rails_helper'

RSpec.describe 'DiaryBookモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { diary_book.valid? }

    let(:customer) { create(:customer) }
    let!(:diary_book) { build(:diary_book, customer_id: customer.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        diary_book.title = ''
        is_expected.to eq false
      end
    end

  end

  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(DiaryBook.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
    context 'DiaryDateモデルとの関係' do
      it '1:Nとなっている' do
        expect(DiaryBook.reflect_on_association(:diary_dates).macro).to eq :has_many
      end
    end
  end
end