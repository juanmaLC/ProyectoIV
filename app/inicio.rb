require 'rubygems'
require 'sinatra'
require 'mongo'
require 'json'
require './lib/ClasesGym' 


set :port, ENV['PORT']
set :bind, '0.0.0.0'



configure do
  db = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'test')  
  set :mongo_db, db[:test]
end


clase1=ClasesGym.new("crossfit","Juan","disponible","10","clase 2.2", "1h")	
clase2=ClasesGym.new("bodypump","Alfonso","disponible",20,"clase 0.7", "45 min")
clase3=ClasesGym.new("karate","Marta","no disponible","0","clase 1.0","30 min")



get '/' do
	content_type :json
	{:status => 'ok'}.to_json
end

get "/status" do
	content_type :json
	{:status => 'ok'}.to_json
end



get '/informacion' do

content_type :json
	{ :informacion => 'Microservicio web de la asignatura Infraestructura Virtual. En los proximos hitos se le añadira clases a este proyecto con diferentes funcionalidades , relaccionadas con la disponibilidad y horario de clases ofrecidas en un gimnasio y reservas de dichas clases',
	  :version => 'hito 5 del proyecto' }.to_json

end 




get "/clases" do



	content_type :json
  	settings.mongo_db.find.to_a.to_json

	
end


get "/InformacionClase1" do
	

	content_type:json
	clase1.to_json

	


end 

get "/InformacionClase2" do
	

	
	content_type:json
	clase2.to_json


end 

get "/InformacionClase3" do
	

	
	content_type:json
	clase3.to_json


end 


post "/crearActividad" do

	
	
	 content_type :json
  	 db = settings.mongo_db
 	 result = db.insert_one params
  	 db.find(:_id => result.inserted_id).to_a.first.to_json


end 



delete '/eliminarActividad' do
  
	content_type :json
  	db = settings.mongo_db
  	id = object_id(params[:id])
  	documents = db.find(:_id => id)
  		if !documents.to_a.first.nil?
    			documents.find_one_and_delete
			{:success => "Eliminado con exito /clases para comprobar que ha sido borrada"}.to_json
  		else
    			{:success => "No se pudo borrar , id invalida o inexistente"}.to_json
  		end
end




put '/actualizarActividad/?' do

	content_type :json
	id = object_id(params[:id])
	name = params[:modalidad]
	settings.mongo_db.find(:_id => id).find_one_and_update('$set' => {:modalidad => name})
  	document_by_id(id)

end



helpers do
  # a helper method to turn a string ID
  # representation into a BSON::ObjectId
  def object_id val
    begin
      BSON::ObjectId.from_string(val)
    rescue BSON::ObjectId::Invalid
      nil
    end
  end

  def document_by_id id
    id = object_id(id) if String === id
    if id.nil?
      {}.to_json
    else
      document = settings.mongo_db.find(:_id => id).to_a.first
      (document || {}).to_json
    end
  end
end










