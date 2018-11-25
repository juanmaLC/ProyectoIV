require './lib/test1'  

require 'json'


clases= Array.new
file = File.read('datos/clasesOfrecidas.json')
datos=JSON.parse(file)
contador=0
datos.each{

	|clase| 

	clases[contador]=Clases.new(clase["modalidad"],clase["profesor"],clase["disponible"])
	contador=contador+1

}





describe 'test1 : ' do
	
	it 'nombres correctos' do
		
		clases.each{

			|clase| clase.mostrarProfesor() != nil

		}
	end



	it 'modalidades correctas' do
    		clases.each{

			|clase| clase.mostrarModalidad() != nil

		}
	end


	it 'clases disponibles ' do
		clases.each{

			|clase| clase.mostrarDisponibilidad() != nil

		}
	end

end
