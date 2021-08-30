#Controllerテスト
require 'rails_helper' #コメントアウトしても動く

RSpec.describe CardsController, type: :controller do
    describe 'GET #top' do
        context 'top' do
            it 'topを表示すること' do
                get :top
                expect(response).to be_success
            end
        end #content
        context 'return 200' do
            it 'have_http_status "200"を表示すること' do
                get :top
                expect(response).to have_http_status "200"
            end
        end #content
    end #describe

    describe 'POST #submit' do
        context 'submit' do
            # let(:params){{submit_card: "D1 D10 S9 C5 C4"}}
            it 'correct response' do
                @params = {submit_card: "D1 D10 S9 C5 C4"}
                post :submit, params: @params #params: @param の意味ってなんだっけ,ちゃんと思い出す
                expect(response).to be_success
            end
        end #context
        context 'return 200' do
            it 'post 200を表示すること' do
                @params = {submit_card: "D1 D10 S9 C5 C4"}
                post :submit, params: @params
                expect(response).to have_http_status "200"
            end
        end #context
    end #describe
end #RSpec



