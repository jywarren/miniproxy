require 'net/http'

class ProxyController < ApplicationController

	def index
		url = URI.parse(params[:q])
		req = Net::HTTP::Get.new(url.path, {"User-Agent" => "MiniProxy"})
		res = Net::HTTP.start(url.host, url.port) {|http|
		  http.request(req)
		}
		if params[:q][-3..0] == "jpg"
			headers['Content-Type'] = 'image/jpeg'
		elsif params[:q][-3..0] == "png"
			headers['Content-Type'] = 'image/png'
		elsif params[:q][-3..0] == "gif"
			headers['Content-Type'] = 'image/gif'
		else
			#params[:q] = params[:q]+"/" if params[:q].last != "/"
			body = res.body.gsub(/http:/,'https://'+request.host+'/?q=http:')	
		end
		render :text => body
	end

end
