class ClasesGym

	


	def initialize(modalidad,profesor,disponible,espacios_libres,clase,duracion)

		@modalidad=modalidad
		@profesor=profesor
		@disponible=disponible
		@espacios_libres=espacios_libres
		@clase=clase
		@duracion=duracion
	
	end


	def getProfesor
		
		return @profesor
	end


	def getModalidad
		
		return @modalidad	
	end

	def getDisponibilidad
		
		return @disponible
	end

	def getEspaciosLibres

		return @espacios_libres
		
	end

	def getClase
		
		return @clase
	end

	def getDuracion

		return @duracion

	end


	def to_s
		
		infoClase= "Clase de #{@modalidad} impartida por el porfesor #{@profesor}, #{@disponible}"

		


	end


	def to_json

		{"modalidad" => "#{@modalidad}",
		 "profesor" => "#{@profesor}",
		 "disponible" => "#{@disponible}",
		 "espacios libres" => "#{@espacios_libres}",
		 "lugar" => "#{@clase}",
		 "duracion" => "#{@duracion}"}.to_json
		


	end

	
	


end






