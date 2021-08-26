module V1 #v1>cards
    class Cards < Grape::API #classを作成してGRAPEを継承
      format :json

        resources :cards do #namespace method？無いと動かんので,とりあえず置いといた.namespace or resourcesどっちでもいい

        desc 'return' #機能の説明.こいつは無意味.ただの宣言で,なくても動く.

            params do #パラメータの制御
                requires :cards, type: Array, desc: 'Cards' #desc以降は要らない.なくても動く.
            end
            response = {}
            errors = nil
            judges = nil

            errors = []
            judges = []
byebug
            post '/' do  #HTTPメソッドに対応した処理を定義 get,postどっちでも動くからどっちでも良さそう
                array_cards = params[:cards] #jsonで入ってきたカードたちを格納
                array_cards.each do |card| #カードを1セットずつ確認する
                    @original_card = Card.new(cards: card)
                    @error = @original_card.hand_validation #ここではerror_elementが返却される
                    if @error
                        errors.push @error #push method で配列errorsにerror_element追加
                    elsif
                        @judge = @original_card.hand_judge #ここではjudge_elementが返却される
                        judges.push @judge #push method で配列judges judge_element追加
                    end
                end #each

                ranking = judges.sort_by!{|a| a[:rank]} #役の強さを判定
                ranking[0][:best] = "true"


                response = {
                    "judge_result": judges,
                    "error_result": errors
                    }
                return response

            end #post
        end #resource
    end #class
end #module
#end
