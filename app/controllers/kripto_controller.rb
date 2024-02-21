class KriptoController < ApplicationController
  def process_kripto 
    if params[:button_pressed] == 'encrypt'
      @result = Kripto.encrypt(params[:text], params[:cipher], params[:n], params[:key], params[:m], params[:b])
    elsif params[:button_pressed] == 'decrypt'
      @result = Kripto.decrypt(params[:text], params[:cipher], params[:n], params[:key], params[:m], params[:b])
    end 
    render 'index'
  end
end
