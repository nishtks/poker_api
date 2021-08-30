#apiテスト
require 'rails_helper' #コメントアウトしても動く

RSpec.describe 'Card' do
    describe '#hand_validation' do
        context '正常なデータとエラーデータ' do
            it 'correct response' do
                params = {"cards": ["H1 H13 H12 H11 H10","H9 C9 S900 H2 C2","D7 H1 S3 C5 D11"]}
                post "/api/v1/cards", params: params #params: @param の意味ってなんだっけ,ちゃんと思い出す
                expect(response).to be_success
                expect(JSON.parse(response.body)['judge_result'][0]['card']).to eq "H1 H13 H12 H11 H10"
                expect(JSON.parse(response.body)['judge_result'][0]['judge']).to eq "ストレートフラッシュ"
                expect(JSON.parse(response.body)['judge_result'][0]['best']).to eq "true"
                expect(JSON.parse(response.body)['judge_result'][1]['card']).to eq "D7 H1 S3 C5 D11"
                expect(JSON.parse(response.body)['judge_result'][1]['judge']).to eq "ハイカード"
                expect(JSON.parse(response.body)['judge_result'][1]['best']).to eq "false"
                expect(JSON.parse(response.body)['error_result'][0]['card']).to eq "H9 C9 S900 H2 C2"
                expect(JSON.parse(response.body)['error_result'][0]['error']).to eq "次のカードは不正です。3番目の「S900」。スートDHCS,数字1〜13の組み合わせで入力してください(例：S1)。"
            end
        end #context
        # bundle exec rspec spec/api/v1/cards_spec.rb:30
        context '正常なデータで強い役が2つあるとき' do
            it 'correct response' do
                params = {"cards": ["H2 H13 H12 H11 H1","D1 D2 D3 D4 D5"]}
                post "/api/v1/cards", params: params #params: @param の意味ってなんだっけ,ちゃんと思い出す
                expect(response).to be_success
                expect(JSON.parse(response.body)['judge_result'][0]['card']).to eq "H2 H13 H12 H11 H1"
                expect(JSON.parse(response.body)['judge_result'][0]['judge']).to eq "ストレートフラッシュ"
                expect(JSON.parse(response.body)['judge_result'][0]['best']).to eq "true"
                expect(JSON.parse(response.body)['judge_result'][1]['card']).to eq "D1 D2 D3 D4 D5"
                expect(JSON.parse(response.body)['judge_result'][1]['judge']).to eq "ストレートフラッシュ"
                expect(JSON.parse(response.body)['judge_result'][1]['best']).to eq "true"
            end
        end #context
    end #describe
end #RSpec
