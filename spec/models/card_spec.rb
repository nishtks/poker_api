#modelテスト
require 'rails_helper' #コメントアウトしても動く

RSpec.describe 'Card' do
    describe '#hand_validation' do
        let(:original_card){ Card.new(cards: @params) }
        context '無問題カード' do
            it 'ｎilで回答すること' do
                @params = "S1 S2 S3 S4 S5" #paramsを指定
                #@original_card = Card.new(cards: @params)
                expect(original_card.hand_validation).to eq nil #original_cardってなに？Letに戻る
            end
        end #content

        context '重複カード' do
            it '重複ありで回答すること' do
                @params = "S1 S1 S3 S4 S5"
                #@original_card = Card.new(cards: @params) #letへ移行
                expect(original_card.hand_validation[:error]).to eq "カードが重複しています。"
                #expect(original_card.hand_validation).to eq {:card=>"S1 S1 S3 S4 S5", :error=>"カードが重複しています。"}  #これなぜか失敗した
            end
        end #content

        context 'カード枚数少ない' do
            it '足らんぞ！で回答すること' do
                @params = "S1 S3 S4 S5"
                expect(original_card.hand_validation[:error]).to eq "カード枚数が不足しています。5つのカード指定文字を半角スペース区切りで入力してください（例：S1 H3 D9 C13 S11）。"
            end
        end #content

        context 'カード枚数少ない' do
            it '足らんぞ！で回答すること' do
                @params = "S1S3 S4 S5"
                expect(original_card.hand_validation[:error]).to eq "カード枚数が不足しています。5つのカード指定文字を半角スペース区切りで入力してください（例：S1 H3 D9 C13 S11）。"
            end
        end #content

        context '無' do
            it 'こんなのカードじゃない！それに枚数も足りない！で回答すること' do
                @params = ""
                expect(original_card.hand_validation[:error]).to eq "カード枚数が不足しています。5つのカード指定文字を半角スペース区切りで入力してください（例：S1 H3 D9 C13 S11）。"
            end
        end #content

        context 'カード枚数多い' do
            it '多いぞ！で回答すること' do
                @params = "S1 S2 S3 S4 S5 S6"
                expect(original_card.hand_validation[:error]).to eq "カード枚数が多いです。5つのカード指定文字を半角スペース区切りで入力してください（例：S1 H3 D9 C13 S11）。"
            end
        end #content


        context '得体がしれない数字のカード' do
            it 'こんなのカードじゃない！で回答すること' do
                @params = "S1 S2 S3 S4 S555"
                expect(original_card.hand_validation[:error]).to eq "5番目の「S555」は不正なカードです。スートDHCS,数字1〜13の組み合わせで入力してください(例：S1)。"
            end
        end

        context '得体がしれないスートのカード' do
            it 'こんなのカードじゃない！で回答すること' do
                @params = "S1 S2 S3 S4 YMCA5"
                expect(original_card.hand_validation[:error]).to eq "5番目の「YMCA5」は不正なカードです。スートDHCS,数字1〜13の組み合わせで入力してください(例：S1)。"
            end
        end

        context '得体がしれない数字のカードと枚数が多い' do
            it 'こんなのカードじゃない！それに枚数も多い！で回答すること' do
                @params = "S1 S2 S3 S4 YMCA555 S6"
                expect(original_card.hand_validation[:error]).to eq "カード枚数が多いです。5つのカード指定文字を半角スペース区切りで入力してください（例：S1 H3 D9 C13 S11）。5番目の「YMCA555」は不正なカードです。スートDHCS,数字1〜13の組み合わせで入力してください(例：S1)。"
            end
        end #content
    end #describe

    # describe '#hand_judge' do
    #     let(:original_card){ Card.new(cards: @params) }

    #     context 'スート1種類,連続する数字5つのカード' do
    #         it 'ストレートフラッシュで回答すること' do
    #             @params = "S1 S2 S3 S4 S5"
    #             expect(original_card.hand_judge[:judge]).to eq "ストレートフラッシュ"
    #         end
    #     end #content

    #     context '同じ数字が4つ' do
    #         it 'フォー・オブ・ア・カインドで回答すること' do
    #             @params = "S1 D1 C1 H1 S5"
    #             expect(original_card.hand_judge[:judge]).to eq "フォー・オブ・ア・カインド"
    #         end
    #     end #content

    #     context '同じ数字が3つと2つ' do
    #         it 'フルハウスで回答すること' do
    #             @params = "S1 D1 C1 H5 S5"
    #             expect(original_card.hand_judge[:judge]).to eq "フルハウス"
    #         end
    #     end #content

    #     context 'スートが1種類' do
    #         it 'フラッシュで回答すること' do
    #             @params = "S1 S3 S4 S5 S6"
    #             expect(original_card.hand_judge[:judge]).to eq "フラッシュ"
    #         end
    #     end #content

    #     context '連続する数字5つのカード' do
    #         it 'ストレートで回答すること' do
    #             @params = "S1 C2 H3 D4 S5"
    #             expect(original_card.hand_judge[:judge]).to eq "ストレート"
    #         end
    #     end #content

    #     context '同じ数字が3つ' do
    #         it 'スリー・オブ・ア・カインドで回答すること' do
    #             @params = "S1 D1 C1 H8 S5"
    #             expect(original_card.hand_judge[:judge]).to eq "スリー・オブ・ア・カインド"
    #         end
    #     end #content
    #     context '2つの同じ数字が2組' do
    #         it 'ツーペアで回答すること' do
    #             @params = "S1 D1 C8 H8 S5"
    #             expect(original_card.hand_judge[:judge]).to eq "ツーペア"
    #         end
    #     end #content

    #     context '2つの同じ数字が1組' do
    #         it 'ワンペアで回答すること' do
    #             @params = "S1 D1 C8 H10 S5"
    #             expect(original_card.hand_judge[:judge]).to eq "ワンペア"
    #         end
    #     end #content

    #     context 'yaku nothing' do
    #         it 'ハイカードで回答すること' do
    #             @params = "S1 D2 C8 H10 S5"
    #             expect(original_card.hand_judge[:judge]).to eq "ハイカード"
    #         end
    #     end #content
    # end #describe
end #RSpec
