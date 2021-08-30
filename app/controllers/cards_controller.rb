class CardsController < ApplicationController
  def top
  end

  def submit
    @original_card = Card.new(cards: params[:submit_card]) #viewからは「submit_card」で送られてくる #ここでDBに設定した形から崩すと上手く行かない
    @original_card.make_array
    @ng_card_message = @original_card.card_validation
    @ng_hand_message = @original_card.hand_validation
    @error = @original_card.all_validation
    # エラーがなければ役判定に飛ばす render ではViewファイルを引数として指定する必要がある
    if @error
      render("cards/top")
    elsif
      @sent_judge_card = HandJudgeService.new(@original_card.cards)
      @judge = @sent_judge_card.hand_judge #ここではjudge_elementが返却される
      render("cards/top")
    end # if @error
  end #submit
end #class



