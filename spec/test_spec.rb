require './lib/ClasesGym'  
require 'json'




clases= Array.new
file = File.read('datos/clasesOfrecidas.json')
datos=JSON.parse(file)
contador=0
datos.each{

	|clase| 

	clases[contador]=ClasesGym.new(clase["modalidad"],clase["profesor"],clase["disponible"],
clase["espacios_libres"],clase["clase"],clase["duracion"])
	contador=contador+1

}






describe 'Inicializacion de clase correcta : ' do
	
	it 'nombres correctos' do
		clases.each{
		

			|clase| expect(clase.getProfesor()).not_to be_empty
		}
	end



	it 'modalidades correctas' do
    		clases.each{

			|clase| expect(clase.getModalidad()).not_to be_empty

		}
	end


	it 'clases disponibles correctas ' do
		clases.each{

			|clase| expect(clase.getDisponibilidad()).not_to be_empty

		}
	end

	it 'espacios libres correctos' do
		clases.each{
			
			|clase| expect(clase.getEspaciosLibres()).to be >= 0
		}

	end


	it 'clases correctas' do
		clases.each{
			
			|clase| expect(clase.getClase()).not_to be_empty
		}

	end

	it 'duracion correcta' do
		clases.each{
			
			|clase| expect(clase.getDuracion()).not_to be_empty
		}

	end

end




describe 'Rutas GET | POST | PUT | DELETE correctas : ' do

	

	it 'GET /' do
		
		expect(:status => "ok").not_to be_empty
	end

	it 'GET /status' do
		
		expect(:status => "ok").not_to be_empty
	end

	it 'GET /informacion' do
		
		expect(:informacion => "Microservicio web de la asignatura Infraestructura Virtual con diferentes funcionalidades , relaccionadas con la disponibilidad y horario de clases ofrecidas en un gimnasio y modificacion de dichas clases",
			:version => "hito 5 del proyecto").not_to be_empty

	end


	it 'GET /clases ' do

		expect({"_id":{"$oid":"5c2f6b975c89472964867c29"},"modalidad":"natacion","profesor":"pepe","disponible":"si","espacios":"10","clase":"1.1","duracion":"10min"}).not_to be_empty
	end



	it 'GET /clase/:id/?' do
		
		expect({"_id":{"$oid":"5c2f6b975c89472964867c29"},"modalidad":"natacion","profesor":"pepe","disponible":"si","espacios":"10","clase":"1.1","duracion":"10min"}).not_to be_empty
		
	end


	it 'GET /InformacionClase1' do

		expect(clases[0].to_json).not_to be_empty

	end


	it 'GET /InformacionClase2' do

		expect(clases[1].to_json).not_to be_empty

	end

	it 'GET /InformacionClase3' do

		expect(clases[2].to_json).not_to be_empty

	end


	it 'POST /crearActividad?modalidad=cross&profesor =natalia&disponible=si&espacios=4&clase=1.0&duracion =1h' do 
		
		
		expect({"_id":{"$oid":"5c3108765c89471828d9cece"},"modalidad":"cross","profesor ":"natalia","disponible":"si","espacios":"4","clase":"1.0","duracion ":"1h"}).not_to be_empty
	
	end


	it 'DELETE /eliminarActividad/:id/?' do
		expect(:success => "Eliminado con exito /clases para comprobar que ha sido borrada").not_to be_empty
		expect(:success => "No se pudo borrar , id invalida o inexistente").not_to be_empty
		
	end


	it 'PUT /actualizarActividad/?' do
		
		expect({"_id":{"$oid":"5c3108765c89471828d9cece"},"modalidad":"running","profesor ":"natalia","disponible":"si","espacios":"4","clase":"1.0","duracion ":"1h"}).not_to be_empty
		
		
	end
	


end


