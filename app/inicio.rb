require 'rubygems'
require 'sinatra'
require 'json'
require './lib/ClasesGym' 


set :port, ENV['PORT']
set :bind, '0.0.0.0'




get '/' do
	content_type :json
	{:status => 'ok'}.to_json
end



get '/informacion' do

	content_type :json
	{ :informacion => 'Microservicio web de la asignatura Infraestructura Virtual. En los proximos hitos se le añadira clases a este proyecto con diferentes funcionalidades , relaccionadas con la disponibilidad y horario de clases ofrecidas en un gimnasio y reservas de dichas clases',
	  :version => 'hito 4 del proyecto' }.to_json

end 


get "/status" do
	content_type :json
	{:status => 'ok'}.to_json
end

get "/clases" do

	clase1=ClasesGym.new("crossfit","Juan","disponible","10","clase 2.2", "1h")	
	clase2=ClasesGym.new("bodypump","Alfonso","disponible",20,"clase 0.7", "45 min")
	clase3=ClasesGym.new("karate","Marta","no disponible","0","clase 1.0","30 min")



	content_type:json
	{:Clase1 => clase1.to_s,
	 :Clase2 => clase2.to_s,
	 :Clase3 => clase3.to_s }.to_json
	
end


get "/InformacionClase1" do
	

	clase1=ClasesGym.new("crossfit","Juan","disponible","10","clase 2.2", "1h")
	content_type:json
	clase1.to_json


end 

get "/InformacionClase2" do
	

	clase2=ClasesGym.new("bodypump","Alfonso","disponible",20,"clase 0.7", "45 min")
	content_type:json
	clase2.to_json


end 

get "/InformacionClase3" do
	

	clase3=ClasesGym.new("karate","Marta","no disponible","0","clase 1.0","30 min")
	content_type:json
	clase3.to_json


end 


get "/reservar" do

	
	content_type:json
	{:Info => "se podra reservar la clase en cuestion y el numero de plazas disponibles reducira, se añadirá para el hito 5" }.to_json



end 






