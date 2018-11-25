require 'rubygems'
require 'sinatra'
require 'json'
require './lib/test1' 







get '/' do
	content_type :json
	{:status => 'ok'}.to_json
end



get '/informacion' do

	content_type :json
	{ :informacion => 'Microservicio web de la asignatura Infraestructura Virtual. En los proximos hitos se le añadira clases a este proyecto con diferentes funcionalidades , relaccionadas con la disponibilidad y horario de clases ofrecidas en un gimnasio',
	  :version => 'hito 3 del proyecto' }.to_json

end 




get "/clases" do


	


end

