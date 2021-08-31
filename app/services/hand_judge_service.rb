class HandJudgeService
    attr_accessor :card
    def initialize(card)
        @card = card #想定"D7 H1 S3 C5 D11"の形で来る
    end

    #一組の手札を役判定する.
    def hand_judge
        card_array = @card.scan(/\S+/)
        card_num = @card.scan(/\d+/).map(&:to_i).sort
        card_suit = @card.scan(/[DHCS]/)
        num_count = card_num.uniq.size
        suit_count = card_suit.uniq.size
        suit_count_detail = card_suit.group_by(&:itself).transform_values(&:size)
        num_count_detail = card_num.group_by(&:itself).transform_values(&:size)
        s= card_num.each_cons(2).sum{|l,r| (l - r).abs} #SUM{隣あう数字の差分}
        if suit_count == 1 and ( s == 4 or s == 12)
            j_message = "ストレートフラッシュ"
            rank = 1
            best = "before judge"
        elsif num_count == 2 and num_count_detail.values.max == 4
            j_message = "フォー・オブ・ア・カインド"
            rank = 2
            best = "before judge"
        elsif num_count == 2 and num_count_detail.values.max == 3
            j_message = "フルハウス"
            rank = 3
            best = "before judge"
        elsif suit_count == 1
            j_message = "フラッシュ"
            rank = 4
            best = "before judge"
        elsif s == 4
            j_message = "ストレート"
            rank = 5
            best = "before judge"
        elsif num_count == 3 and num_count_detail.values.max == 3
            j_message = "スリー・オブ・ア・カインド"
            rank = 6
            best = "before judge"
        elsif num_count == 3 and num_count_detail.values.max == 2
            j_message = "ツーペア"
            rank = 7
        elsif num_count == 4 and num_count_detail.values.max == 2
            j_message = "ワンペア"
            rank = 8
            best = "before judge"
        elsif
            j_message = "ハイカード"
            rank = 9
            best = "before judge"
        end #yaku hantei

        if j_message
            judge_statement = j_message
            judge_element = {
                            "card": @card,
                            "judge": judge_statement,
                            "best": best,
                            "rank": rank
                            }
        end #if j_message

        j_message = nil #initialize

        return judge_element
    end #def hand_judge

end