# module Cards
    class PokerBestService
        attr_accessor :hands
        def initialize(hands)
            @hands = hands
        end
        def create_best
            @hands_sortby_rank = @hands.sort_by{|a| a[:rank] }
            @hands_sortby_rank[0][:best] = "ture"
            return @hands_sortby_rank
        end
    end

    #同順1位が未完成
            # @hands_sortby_rank.each do |i,hand_rank|
            #     if @hands_sortby_rank[0][:rank] < @hands_sortby_rank[i + 1][:rank]
            #         @hands_sortby_rank[0][:best] = "true"
            #     elsif @hands_sortby_rank[0][:rank] = @hands_sortby_rank[i+1][:rank]
            #         @hands_sortby_rank[0][:best] = "true"
            #         @hands_sortby_rank[i+1][:best] = "true"
            #     end
            # end