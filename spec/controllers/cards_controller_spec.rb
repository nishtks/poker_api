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
            # let(:params){{content: "D1 D10 S9 C5 C4"}}
            it 'correct response' do
                @params = {content: "D1 D10 S9 C5 C4"}
                post :submit, params: @params #params: @param の意味ってなんだっけ,ちゃんと思い出す
                expect(response).to be_success
            end
        end #content
        context 'return 200' do
            it 'post 200を表示すること' do
                @params = {content: "D1 D10 S9 C5 C4"}
                post :submit, params: @params
                expect(response).to have_http_status "200"
            end
        end #content
    end #describe
end #RSpec




# <%= form_tag("/cards/submit") do %>
#     <input type="string" name="content" > <%# contentがParamsで運ばれる　%>
#     <input type="submit" value="約判定させて〜や">
# <% end %>


# class CardsController < ApplicationController
#     def top
#     end

#     def submit
#       #@original_card = Card.new(cards: params[:content]).cards #ここでDBに設定した形から崩すと上手く行かない
#       @original_card = Card.new(cards: params[:content])
#   byebug
#       @error = @original_card.hand_validation

#       # エラーがなければ役判定に飛ばす render ではViewファイルを引数として指定する必要がある
#       if @error
#         render("cards/top")
#       elsif
#         @judge = @original_card.hand_judge
#         render("cards/top")
#       end # if @error
#     end #submit
#   end #class