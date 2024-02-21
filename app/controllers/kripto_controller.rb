class KriptoController < ApplicationController
  def process_kripto 
    session.delete(:result) if session[:result].present?
    if params[:button_pressed] == 'encrypt'
      @result = Kripto.encrypt(params[:text], params[:cipher], params[:n], params[:key], params[:m], params[:b])
    elsif params[:button_pressed] == 'decrypt'
      @result = Kripto.decrypt(params[:text], params[:cipher], params[:n], params[:key], params[:m], params[:b])
    end 
    if @result.blank?
      redirect_to root_path
    else 
      session[:result] = @result
      render 'index'
    end
  end

  def download_result 
    result_content = session[:result]
    if result_content.present?
        send_data result_content, filename: "result.txt", type: "text/plain"
      else 
      "No result detected"
    end
  end
end
