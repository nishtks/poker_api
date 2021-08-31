#serviceテスト
require 'rails_helper' #コメントアウトしても動く

RSpec.describe 'Card' do
    describe '#best_judge' do
        #let(:sent_judge_card){ HandJudgeService.new(@params) }
        context 'ストレートフラッシュ' do
            it 'ストレートフラッシュをベスト判定すること' do
                @params = [{:card=>"H1 H13 H12 H11 H10", :judge=>"ストレートフラッシュ", :best=>"before judge", :rank=>1}, {:card=>"H1 H2 H13 H12 H11", :judge=>"ストレートフラッシュ", :best=>"before judge", :rank=>1}, {:card=>"H5 H6 D6 D9 H9", :judge=>"ストレート", :best=>"before judge", :rank=>5}]
                @Hands = PokerBestService.new(@params)
                expect(@Hands.create_best[0][:best]).to eq "true"
            end
        end #content
    end #describe
end #RSpec
