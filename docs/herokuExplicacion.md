

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
A continucación añado una captura de pantalla de dicha configuración sobre mi proyecto:
![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/configuracionHeroku.png) 

Con esta configuración cada vez que hagamos un nuevo push a nuestro repositorio y pase los test que tenemos asignados , se realizará el deploy.

# Procfile
El archivo procfile debe de estar en el directorio raíz del proyecto y es el encargado de decirle a heroku que comando tiene que ejecutar para arrancar el microservicio.Yo he utilizado el siguiente

	web: bundle exec rackup -p $PORT
	
$PORT es una variable global que nos indicara el puerto del microservicio

# Config.ru
Este archivo indica a heroku el directorio y el archivo que quiere que ejecute 
	
	require './app/inicio'
	run Sinatra::Application

# Comprobar funcionamiento
En local con:
	
	heroku local
	
Desde el navegador:

	heroku open