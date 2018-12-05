# Desplegar Docker en local

- Vamos al directorio del proyecto y creamos un Dockerfile como el siguiente:


		FROM ruby:2.5

		# throw errors if Gemfile has been modified since Gemfile.lock
		RUN bundle config --global frozen 1


		COPY Gemfile .
		COPY Gemfile.lock .

		COPY app/ .
		COPY app/inicio.rb app/inicio.rb

		COPY datos/ .
		COPY datos/clasesOfrecidas.json datos/clasesOfrecidas.json  

		COPY lib/ .
		COPY lib/ClasesGym.rb lib/ClasesGym.rb
		COPY config.ru .

		RUN bundle install




		CMD ["bundle","exec","rackup","-p", "80" ,"--host", "0.0.0.0"]
	
	
- Construimos la imagen con dicho Dockerfile y la ejecutamos:

![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/pruebaLocal2.png) 

# Explicación del DockerFile

- COPY copiará los archivos que le indiquemos en el contenedor creado , en este caso solo los necesarios para que el microservicio se ejecute correctamente.
- RUN bundle install instalara las dependencias del archivo Gemfile y las copiará en Gemfile.lock para no tener que buscarlas e instalarlas cada vez que se ejecute el contenedor.
- CMD en este caso despliega el microservicio e indica que se inicia en el puerto 80 con host en 0.0.0.0
- A diferencia del Procfile , en este si hay que indicarle el host en el que se ejecutará.

# DockerHub

- Para bajar la imagen directamente con un solo comando se utilizara:

		docker pull juanmalc/proyectoiv
		
- Esto se consigue creando un repositorio en DockerHub y vinculandolo con nuestro repositorio de GitHub

![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/dockerhub.png) 

# Desplegar Docker en Heroku

- Para ello necesitamos el fichero heroku.yml

	
		build:
  		docker:
    		web: Dockerfile
		run:
  		web: bundle exec rackup -p $PORT --host 0.0.0.0

 
- Este fichero hace que a la hora de construir la imagen y subirla a la app de heroku , se cambie el CMD del Dockerfile por el comando run del fichero heroku.yml. Es casi el mismo comando solo que en lugar de indicarle el puerto 80 , le indicamos el puerto con $PORT para que coja el puerto que heroku internamente tiene asignado en ese momento.

- Se despliegua con:

		git push heroku master
		
Captura de pantalla de la ejecución:
![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/heroku.png) 
		
		
- La app de heroku llamada proyectoiv1819docker la cree desde la web y para saber que lo que he desplegado es un contenedor utilicé el comando: 

		heroku apps:info -a proyectoiv1819docker
	
![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/esUnContenedor.png) 
		
- Todos los pasos seguidos los encontre en la documentación de Heroku 

[Documentación Oficial](https://devcenter.heroku.com/articles/container-registry-and-runtime) 
[Desplegar con Heroku.yml](https://devcenter.heroku.com/articles/buildpack-builds-heroku-yml)
