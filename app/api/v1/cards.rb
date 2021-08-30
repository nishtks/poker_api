module V1 #v1>cards
    class Cards < Grape::API #classを作成してGRAPEを継承
    format :json
        resources :cards do #namespace method？無いと動かんので,とりあえず置いといた.namespace or resourcesどっちでもいい
        desc 'return' #機能の説明.こいつは無意味.ただの宣言で,なくても動く.
            params do #パラメータの制御
                requires :cards, type: Array, desc: 'Cards' #desc以降は要らない.なくても動く.
            end
            response = {}
            errors = []
            judges = []
            post '/' do  #HTTPメソッドに対応した処理を定義 get,postどっちでも動くからどっちでも良さそう
                array_cards = params[:cards] #jsonで入ってきたカードたちを格納
                array_cards.each do |card| #カードを1セットずつ確認する
                    @original_card = Card.new(cards: card)
                    @original_card.make_array
                    @ng_card_message = @original_card.card_validation
                    @ng_hand_message = @original_card.hand_validation
                    @error = @original_card.all_validation
                    if @error
                        errors.push @error #push method で配列errorsにerror_element追加
                    elsif
                        @sent_judge_card = HandJudgeService.new(card)
                        @judge = @sent_judge_card.hand_judge #ここではjudge_elementが返却される
                        judges.push @judge #push method で配列judges judge_element追加
                    end
                end #each
                before_judges = PokerBestService.new(judges) #役のベスト判定を行う
                @best_judges = before_judges.create_best
                response = {
                    "judge_result": @best_judges,
                    "error_result": errors
                    }
                return response
            end #post
        end #resource
    end #class
end #module
#end
