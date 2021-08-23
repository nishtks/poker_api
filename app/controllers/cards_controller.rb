class CardsController < ApplicationController
  def top
  end

  def submit
    
    #@original_card = Card.new(cards: params[:content]).cards #ここでDBに設定した形から崩すと上手く行かない
    @original_card = Card.new(cards: params[:content])
byebug
    @error = @original_card.hand_validation

    # エラーがなければ役判定に飛ばす render ではViewファイルを引数として指定する必要がある
    if @error
      render("cards/top")
    elsif
      @judge = @original_card.hand_judge
      render("cards/top")
    end # if @error
  end #submit
end #class
