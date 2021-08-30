class Card < ApplicationRecord
    #DB設計は      t.string :cards
    def make_array
        @card =self.cards
        @card_array = @card.scan(/\S+/)
    end


    def card_validation #トランプのカードとして正しいか
        @ng_card_list = ""
        @card_array.each.with_index(1) do |content,i|
            if  content.match(/[DHCS](1[0-3]|[1-9])$/)
            elsif
                @ng_card = "#{i}番目の「#{content}」"
                @ng_card_list << @ng_card
            end
        end #Scan
        if @ng_card_list.empty?
            @ng_card_message == nil
        elsif
            @ng_card_message = "次のカードは不正です。#{@ng_card_list}。スートDHCS,数字1〜13の組み合わせで入力してください(例：S1)。"
        end
        return @ng_card_message
    end #card_validation


    def hand_validation # ポーカーの枚数として正しいか？枚数と重複を確認
        @card_length = @card_array.length
        @card_count = @card_array.group_by(&:itself).length
        if  @card_length < 5
            @ng_hand_message ="カード枚数が不足しています。5つのカード指定文字を半角スペース区切りで入力してください（例：S1 H3 D9 C13 S11）。"
        elsif @card_length > 5
            @ng_hand_message ="カード枚数が多いです。5つのカード指定文字を半角スペース区切りで入力してください（例：S1 H3 D9 C13 S11）。"
        elsif @card_count != 5
            @ng_hand_message = "カードが重複しています。"
        elsif
            @ng_hand_message == nil
        end
        return @ng_hand_message
    end #hand_validation


    def all_validation #バリデーションひっかかったやつらをマージ
        if @ng_hand_message or @ng_card_message
            error_statement = "" #error内容の格納先を作成
            if @ng_card_message
            error_statement << @ng_card_message
            end
            if @ng_hand_message
            error_statement << @ng_hand_message
            end
            if error_statement
            error_element = {
                            "card": @card,
                            "error": error_statement
                            }
            end
            @v_message1 = nil #initialize
            @v_message2 = nil #initialize
            return error_element
        end #@v_message1 or @v_message2
    end #all_validation


    # def hand_judge #####こちらはサービスに移管した
    #     @card_num = @card.scan(/\d+/).map(&:to_i).sort
    #     @card_suit = @card.scan(/[DHCS]/)
    #     @num_count = @card_num.uniq.size
    #     @suit_count = @card_suit.uniq.size
    #     @suit_count_detail = @card_suit.group_by(&:itself).transform_values(&:size)
    #     @num_count_detail = @card_num.group_by(&:itself).transform_values(&:size)
    #     @s= @card_num.each_cons(2).sum{|l,r| (l - r).abs} #SUM{隣あう数字の差分}
    #     if @suit_count == 1 and ( @s == 4 or @s == 12)
    #         @j_message = "ストレートフラッシュ"
    #         rank = 1
    #         best = "false"
    #     elsif @num_count == 2 and @num_count_detail.values.max == 4
    #         @j_message = "フォー・オブ・ア・カインド"
    #         rank = 2
    #         best = "false"
    #     elsif @num_count == 2 and @num_count_detail.values.max == 3
    #         @j_message = "フルハウス"
    #         rank = 3
    #         best = "false"
    #     elsif @suit_count == 1
    #         @j_message = "フラッシュ"
    #         rank = 4
    #         best = "false"
    #     elsif @s == 4
    #         @j_message = "ストレート"
    #         rank = 5
    #         best = "false"
    #     elsif @num_count == 3 and @num_count_detail.values.max == 3
    #         @j_message = "スリー・オブ・ア・カインド"
    #         rank = 6
    #         best = "false"
    #     elsif @num_count == 3 and @num_count_detail.values.max == 2
    #         @j_message = "ツーペア"
    #         rank = 7
    #     elsif @num_count == 4 and @num_count_detail.values.max == 2
    #         @j_message = "ワンペア"
    #         rank = 8
    #         best = "false"
    #     elsif
    #         @j_message = "ハイカード"
    #         rank = 9
    #         best = "false"
    #     end #yaku hantei

    #     if @j_message
    #         judge_statement = @j_message
    #         judge_element = {
    #                         "card": @card,
    #                         "judge": judge_statement,
    #                         "best": best,
    #                         "rank": rank
    #                         }
    #     end #if @j_message

    #     @j_message = nil #initialize

    #     return judge_element
    # end #def hand_judge
end #Card < ApplicationRecord
