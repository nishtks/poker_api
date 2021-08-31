#modelテスト
#文字列が違っていそう.そもそものアウトプットの日本語も変更されているので,ここは修正


require 'rails_helper' #コメントアウトしても動く

RSpec.describe 'Card' do
    describe '#hand_validation' do
        let(:original_card){ Card.new(cards: @params) }
        context '無問題カード' do
            it 'ｎilで回答すること' do
                @params = "S1 S2 S3 S4 S5" #paramsを指定
                #@original_card = Card.new(cards: @params)
                original_card.make_array
                original_card.card_validation
                original_card.hand_validation
                expect(original_card.all_validation).to eq nil #original_cardってなに？Letに戻る
            end
        end #content

        context '重複カード' do
            it '重複ありで回答すること' do
                @params = "S1 S1 S3 S4 S5"
                #@original_card = Card.new(cards: @params) #letへ移行
                original_card.make_array
                original_card.card_validation
                original_card.hand_validation
                expect(original_card.all_validation[:error]).to eq "カードが重複しています。"
                #expect(original_card.hand_validation).to eq {:card=>"S1 S1 S3 S4 S5", :error=>"カードが重複しています。"}  #これなぜか失敗した
            end
        end #content

        context 'カード枚数少ない' do
            it '足らんぞ！で回答すること' do
                @params = "S1 S3 S4 S5"
                original_card.make_array
                original_card.card_validation
                original_card.hand_validation
                expect(original_card.all_validation[:error]).to eq "カード枚数が不足しています。5つのカード指定文字を半角スペース区切りで入力してください（例：S1 H3 D9 C13 S11）。"
            end
        end #content

        context 'カード枚数少ない' do
            it '足らんぞ！で回答すること' do
                @params = "S1S3 S4 S5"
                original_card.make_array
                original_card.card_validation
                original_card.hand_validation
                expect(original_card.all_validation[:error]).to eq "カード枚数が不足しています。5つのカード指定文字を半角スペース区切りで入力してください（例：S1 H3 D9 C13 S11）。"
            end
        end #content

        context '無' do
            it 'こんなのカードじゃない！それに枚数も足りない！で回答すること' do
                @params = ""
                original_card.make_array
                original_card.card_validation
                original_card.hand_validation
                expect(original_card.all_validation[:error]).to eq "カード枚数が不足しています。5つのカード指定文字を半角スペース区切りで入力してください（例：S1 H3 D9 C13 S11）。"
            end
        end #content

        context 'カード枚数多い' do
            it '多いぞ！で回答すること' do
                @params = "S1 S2 S3 S4 S5 S6"
                original_card.make_array
                original_card.card_validation
                original_card.hand_validation
                expect(original_card.all_validation[:error]).to eq "カード枚数が多いです。5つのカード指定文字を半角スペース区切りで入力してください（例：S1 H3 D9 C13 S11）。"
            end
        end #content


        context '得体がしれない数字のカード' do
            it 'こんなのカードじゃない！で回答すること' do
                @params = "S1 S2 S3 S4 S555"
                original_card.make_array
                original_card.card_validation
                original_card.hand_validation
                expect(original_card.all_validation[:error]).to eq "次のカードは不正です。5番目の「S555」。スートDHCS,数字1〜13の組み合わせで入力してください(例：S1)。"
            end
        end


        context '得体がしれないスートのカード' do
            it 'こんなのカードじゃない！で回答すること' do
                @params = "S1 S2 S3 S4 YMCA5"
                original_card.make_array
                original_card.card_validation
                original_card.hand_validation
                expect(original_card.all_validation[:error]).to eq "次のカードは不正です。5番目の「YMCA5」。スートDHCS,数字1〜13の組み合わせで入力してください(例：S1)。"
            end
        end

        context '得体がしれない数字のカードと枚数が多い' do
            it 'こんなのカードじゃない！それに枚数も多い！で回答すること' do
                @params = "S1 S2 S3 S4 YMCA555 S6"
                original_card.make_array
                original_card.card_validation
                original_card.hand_validation
                expect(original_card.all_validation[:error]).to eq "次のカードは不正です。5番目の「YMCA555」。スートDHCS,数字1〜13の組み合わせで入力してください(例：S1)。カード枚数が多いです。5つのカード指定文字を半角スペース区切りで入力してください（例：S1 H3 D9 C13 S11）。"
            end
        end #context
    end #describe
end #RSpec
