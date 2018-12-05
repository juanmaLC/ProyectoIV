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
