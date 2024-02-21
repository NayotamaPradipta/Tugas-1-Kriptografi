require 'base64'
class KriptoController < ApplicationController
  def process_kripto 
    session.delete(:result) if session[:result].present?
    session.delete(:result_base64) if session[:result_base64].present?
    input_text = case params[:input_type] 
                  when 'text' 
                    params[:text]
                  when 'file' 
                    params[:file].read if params[:file].present?
                  end



    if params[:button_pressed] == 'encrypt'
      @result = Kripto.encrypt(input_text, params[:cipher], params[:n], params[:key], params[:m], params[:b])
      @result_base64 = Base64.encode64(@result)
    elsif params[:button_pressed] == 'decrypt'
      @result = Kripto.decrypt(input_text, params[:cipher], params[:n], params[:key], params[:m], params[:b])
      @result_base64 = Base64.encode64(@result)
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
        filename = "result"
        content_type = params[:format] == 'binary' ? 'application/octet-stream' : 'text/plain'
        filename += params[:format] == 'binary' ? '.bin' : '.txt'
        send_data result_content, filename: filename, type: content_type
      else 
        "No result detected"
    end
  end
end
