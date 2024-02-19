class KriptoController < ApplicationController
  def process_kripto 
    if params[:button_pressed] == 'encrypt'
      @result = Kripto.encrypt(params[:text], params[:cipher], params[:key])
    elsif params[:button_pressed] == 'decrypt'
      @result = Kripto.decrypt(params[:text], params[:cipher], params[:key])
    end 
    render 'index'
  end
end
