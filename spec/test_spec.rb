require './lib/test1'  

clasePrueba = Clases.new("crossfit","Juan","1")


describe 'test1 : ' do
	
	it 'nombre correcto' do
    		clasePrueba.mostrarProfesor() != nil
	end



	it 'modalidad correcta' do
    		clasePrueba.mostrarModalidad() != nil
	end


	it 'clase disponible ' do
		clasePrueba.mostrarDisponibilidad() != nil
	end

end
