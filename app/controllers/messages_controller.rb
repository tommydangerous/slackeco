class MessagesController < ApplicationController
  before_filter :valid_trigger_word?, except: :list

  def handle
    handler = ::MessageHandler.new(params[:trigger_word], params[:user_name], params[:text])
    response = handler.process!

    render json: response.to_json
  end

  def list
    @memes = MEME_DATABASE.memes
  end

private

  def valid_trigger_word?
    unless [ENV['MEME_TRIGGER_WORD']].include?(params[:trigger_word])
      render json: {error: 'invalid trigger_word'}.to_json
      return
    end
  end
end
