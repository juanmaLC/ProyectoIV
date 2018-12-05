[![Build Status](https://travis-ci.org/juanmaLC/ProyectoIV.svg?branch=master)](https://travis-ci.org/juanmaLC/ProyectoIV)

# ProyectoIV
Repositorio creado para el proyecto de la asignatura Infraestructura Virtual
El proyecto tratara de un servicio web para una cadena de un gimnasios, para poder tener registrados
a todos los clientes y que cada uno pueda reservar con antelación y comodidad a que clases asistirá.




# Herramientas utilizadas para el desarrollo
- El lenguaje para desarrolar el servicio web será Ruby
- El framework utilizado será Sinatra
- Los test elegidos para evaluar el código desarollado serán RSpec
- La base de datos para guardar la información necesaria será MySQL


# Ejecución de test 

    $> rspec
    
    
    
 
# Descipcion
 

Uso de esta clase para comprobar correcta inicializacion

# Enlace a la documentacion
[Explicacion](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/testIntegracion.md) 


# PaaS Heroku


Despliegue: [proyectoIV](https://proyectoiv1819.herokuapp.com/) 

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://proyectoiv1819.herokuapp.com/)


Con /informacion el microservicio mostrara informacion sobre el microservicio.
Con /clases el microservicio mostrará las clases ofertadas.
Con /InformacionClase1 , /InformacionClase2 , InformacionClase3 , se mostrara información extendida la clase en cuestión.

Me he decantado por heroku ya que es gratuito , hay mucha información de como usarlo y es bastante sencillo de usar.
Más documentación sobre mi despliegue en heroku [aqui](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/herokuExplicacion.md) 

# Docker en Heroku

[Contenedor](https://proyectoiv1819docker.herokuapp.com/) 

[Repositorio DockerHub](https://hub.docker.com/r/juanmalc/proyectoiv/)

[Documentación extendida sobre el desarrollo en Docker](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/docker.md)  
