# Desplegar Docker en local

- Instalamos docker en nuestro ordenador
- Vamos al directorio del proyecto y creamos un dockerfile para el docker en local:


		FROM ruby:2.5
		RUN bundle config --global frozen 1
		COPY Gemfile Gemfile.lock ./
		COPY . .
		RUN bundle install
		CMD ["bundle","exec","rackup","--host","0.0.0.0","-p","80"]
	
	
- Contruimos la imagen con dicho dockerfile y la ejecutamos:

![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/pruebaLocal1.png) 

![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/pruebaLocal2.png) 



# Desplegar Docker en Heroku

- Primero creamos cuenta en DockerHub y creamos un repositorio vinculado al repositorio de nuestro proyecto en GitHub. Con esto cada vez que hagamos un push al repositorio se creará una nueva imagen actualizada.

![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/dockerhub.png) 

- Hacemos un push al repositorio git con el Dockerfile configurado para heroku

		FROM ruby:2.5
		RUN bundle config --global frozen 1
		COPY Gemfile Gemfile.lock ./
		COPY . .
		RUN bundle install
		CMD ["ruby","app/inicio.rb"]
	
	
- Con esto se creará la nueva imagen en nuestro repositorio DockerHub. La podemos bajar con la orden:


		docker pull juanmalc/proyectoiv
		

![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/dockerpull.png) 


- Creamos una nueva app en Heroku , en mi caso lo hice desde la web.

- Hacemos un log en heroku para etener permiso y poder hacer el push de la imagen

![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/login.png) 

- Ahora cambiamos el nombre a la imagen , ya que para subirlo a un contenedor de heroku debe de tener un nombre particular, subimos la imagen y hacemos el release del contenedor:

![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/tag-push-release.png) 

![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/funcionamientodocker.png) 

![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/container.png) 


- Todos los pasos seguidos los encontre en la documentación de Heroku 

[Documentación Oficial](https://devcenter.heroku.com/articles/container-registry-and-runtime) 
