#serviceテスト
require 'rails_helper' #コメントアウトしても動く

RSpec.describe 'Card' do
    describe '#hand_judge' do
        let(:sent_judge_card){ HandJudgeService.new(@params) }
        context 'スート1種類,連続する数字5つのカード' do
            it 'ストレートフラッシュで回答すること' do
                @params = "S1 S2 S3 S4 S5"
                # sent_judge_card = HandJudgeService.new(@params)
                expect(sent_judge_card.hand_judge[:judge]).to eq "ストレートフラッシュ"
            end
        end #content

        context '同じ数字が4つ' do
            it 'フォー・オブ・ア・カインドで回答すること' do
                @params = "S1 D1 C1 H1 S5"
                expect(sent_judge_card.hand_judge[:judge]).to eq "フォー・オブ・ア・カインド"
            end
        end #content

        context '同じ数字が3つと2つ' do
            it 'フルハウスで回答すること' do
                @params = "S1 D1 C1 H5 S5"
                expect(sent_judge_card.hand_judge[:judge]).to eq "フルハウス"
            end
        end #content

        context 'スートが1種類' do
            it 'フラッシュで回答すること' do
                @params = "S1 S3 S4 S5 S6"
                expect(sent_judge_card.hand_judge[:judge]).to eq "フラッシュ"
            end
        end #content

        context '連続する数字5つのカード' do
            it 'ストレートで回答すること' do
                @params = "S1 C2 H3 D4 S5"
                expect(sent_judge_card.hand_judge[:judge]).to eq "ストレート"
            end
        end #content

        context '同じ数字が3つ' do
            it 'スリー・オブ・ア・カインドで回答すること' do
                @params = "S1 D1 C1 H8 S5"
                expect(sent_judge_card.hand_judge[:judge]).to eq "スリー・オブ・ア・カインド"
            end
        end #content
        context '2つの同じ数字が2組' do
            it 'ツーペアで回答すること' do
                @params = "S1 D1 C8 H8 S5"
                expect(sent_judge_card.hand_judge[:judge]).to eq "ツーペア"
            end
        end #content

        context '2つの同じ数字が1組' do
            it 'ワンペアで回答すること' do
                @params = "S1 D1 C8 H10 S5"
                expect(sent_judge_card.hand_judge[:judge]).to eq "ワンペア"
            end
        end #content

        context 'yaku nothing' do
            it 'ハイカードで回答すること' do
                @params = "S1 D2 C8 H10 S5"
                expect(sent_judge_card.hand_judge[:judge]).to eq "ハイカード"
            end
        end #content
    end #describe
end #RSpec
