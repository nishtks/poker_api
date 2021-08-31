# module PokerBestService

class PokerBestService
    attr_accessor :hands

    def initialize(hands)
        @hands = hands
    end

    def create_best
        best_score = @hands.map{|hash| hash[:rank]}.min #役強いほど数値(INT)が小さい
        @hands.each do |hand,i|
            if hand[:rank] == best_score
                hand[:best] = "true"
            elsif
                hand[:best] = "false"
            end
        end
        return @hands
    end
end

# end