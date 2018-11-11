

# Instalación
Para instalar en nuestra maquina usamos :
	
	sudo snap install heroku --clasic 
	
Instalacion de las gemas:

	gem install bundler

Una vez editado el Gemfile con las dependencias que necesitamos:

	bundle install



# Despliegue 	
Podemos crear la app de heroku desde la terminal o desde la web. 
Yo la cree por la web ya que es muy sencillo. Una vez creada nos vamos al apartado deploy , y seleccionamos el metodo de github , lo conectamos con el repositorio que queramos y activamos el "Automatic deploys". Tambien si tenemos integración continua podemos hacer que solo se haga el deploy si los test se pasaron correctamente.


# Comprobar funcionamiento
En local con:
	
	heroku local
	
Desde el navegador:

	heroku open