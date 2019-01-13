# Despliegue de la máquina en Azure con Vagrant
Para desplegar nuestro microservicio en Azure primeramente necesitamos crear una maquina virtual en nuestra cuenta de azure con las características que que nosotros veamos oportunas.
Para crear la máquina virtual en Azure he utilizado la herramienta Vagrant. 

Con:
	
	vagrant init 
	
Se crea el fichero vagrantfile el cual yo configuré de la siguiente manera:
[Vagrantfile](https://github.com/juanmaLC/ProyectoIV/blob/master/Vagrantfile) 

		Vagrant.configure("2") do |config|

			config.vm.box='azure'
			# Key usada para la conexion ssh
  			config.ssh.private_key_path = '~/.ssh/id_rsa'
	
			#Configuración de valores de azure
			config.vm.provider :azure do |azure, override|

				#Valores personales de azure
				azure.tenant_id = ENV['AZURE_TENANT_ID']
    				azure.client_id = ENV['AZURE_CLIENT_ID']
    				azure.client_secret = ENV['AZURE_CLIENT_SECRET']
    				azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']
		


				# Parametros de la maquina virtual , nombre , tamaño solicitado, imagen usada , grupo de recursos , abrir puerto 80 y localizacion
    				azure.vm_name = 'proyectoivgym'
   				azure.vm_size = 'Standard_A0'
    				azure.vm_image_urn = 'Canonical:UbuntuServer:16.04-LTS:latest'
    				azure.resource_group_name = 'ProyectoIVVagrant'
				azure.tcp_endpoints = 80
				azure.location = "westeurope"
		
			end


	
			#Configuracion del provisionamiento
			config.vm.provision "ansible" do |ansible|
				ansible.playbook = "provision/playbook.yml"
			end


		end
	
Una vez que tenemos configurado el Vagrantfile iniciamos el proceso de creación de la maquina con el comando:

	vagrant up
	
Caprura de pantalla para mostrar que se ha utilizado Vagrant:

![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/vagrant.png) 


	
**Configuración del archivo Vagrantfile**

- config.vm : Configuración de la máquina que Vagrant va a manejar.
- config.vm.box : le indicamos a la maquina que box va a utilizar, en este caso la de azure.
- config.vm.provider : configuración del porveedor , es decir , donde vamos a hostear la maquina.
- azure .vm_name: nombre de la máquina que se va a crear, además,este será el nombre de dominio de nuestra máquina, por lo que no puede haber dos iguales.
- azure.vm.size : tamaño de los recursos de la maquina , en mi caso el Estándar A0 consta de (1 vcpu, 0.75 GB de memoria), algo más que suficiente para mi microservicio.
- azure.vm_image_urn : imagen que vamos a instalarle a la máquina, en este caso , Ubuntu Server 16.04 LTS , ya que estoy acostumbrado a utilizar ubuntu y para servidor la version 16.04 LTS ya que esta actualizada y tendrá menos fallos en seguridad que probablemente versiones más recientes.
- azure.resource_group_name: grupo de recursos en el que será creada la máquina.
- azure.tcp_endpoints : para abrir el puerto 80 y poder acceder a nuestro microservicio.
- azure.location: lugar donde queremos el host, escogí oeste de europa por mejor conexión.
- config.ssh.private_key_path: para especificarle la key para la conexion ssh. 
- azure.client_id: id del cliente azure
- azure.subscription_id: id de la suscripción
- azure.client_secret: contraseña del id del cliente
- (Los valores personales de azure van con varibles de entorno ya que son personales y cada persona que vaya a desplegar dicha máquina tendrá los suyos propios).

- config.vm.provision : para cargar el archivo de provisión durante el vagrant up

[Documentacion cli vagrant](https://www.vagrantup.com/docs/cli/) 

[Ansible con Vagrant](https://www.vagrantup.com/docs/provisioning/ansible.html) 	

[Configuracion para desplegar maquina azure con vagrant](https://blog.scottlowe.org/2017/12/11/using-vagrant-with-azure/)

[Tamaño de la máquina](https://docs.microsoft.com/es-es/azure/virtual-machines/windows/sizes-general) 
	

# Aprovisionamiento de la máquina

Una vez que tenemos nuestra máquina virtual creada en azure con nuestro archivo Vagrantfile debemos de instalarle todos los paquetes y requisitos necesarios para que nuestro microservicio se pueda ejecutar correctamente.


Para el aprovisionamiento de la máquina he utilizado la herramienta ansible.
El archivo de configuración que he utilizado es el siguiente:
[playbook.yml](https://github.com/juanmaLC/ProyectoIV/blob/master/provision/playbook.yml) 

	---
  	- hosts: all
    

    tasks:

      - name: Actualizar paquetes
        apt:
         update_cache: yes
        become: true

      - name: Ruby
        apt: pkg=ruby state=latest
        become: true

      
      - name: gcc
        apt: pkg=gcc state=latest
        become: true

      - name: make
        apt: pkg=make state=latest
        become: true
      
      - name: ruby-dev
        apt: pkg=ruby-dev state=latest
        become: true

      - name: mongodb
        apt: pkg=mongodb state=latest
        become: true

      - name: Bundler
        apt: pkg=bundler state=latest
        become: true

      - name: Clonar el repositorio
        git: repo=https://github.com/juanmaLC/ProyectoIV.git dest=ProyectoIV/  

      
    
      - gem: 
         name: sinatra
         state: latest

      - gem: 
         name: bundler
         state: latest
      

      - gem: 
         name: rspec
	state: latest
	

**Configuración del archivo playbook.yml**

- Con hosts : all permitimos que se pueda realizar el aprovisionamiento sobre todos los hosts definidos en el fichero /etc/ansible/hosts 
- En el primer task , lo que realizo es una actualización de todos los paquetes.
- Del segundo task  al séptimo instalo los paquetes que mi microservicio necesita. Instalo ruby , el compilador gcc , la orden make , ruby-dev (necesario para poder instalar gemas nativas), la base de datos (mongodb), y la orden bunlder.
- En el octavo task clono mi repositorio git .
- Los tres ultimos task son para instalar las tres gemas necesarias , sinatra , bundler y rspec (test).


La forma para instalar los paquetes es la siguiente:

- name: le podemos el nombre que queramos al task , es identificativo.
- apt: es tulizado para instalar los paquetes. En pkg indicamos el nombre del paquete que vamos a instalar , en state : latest que la version instalada sea la última y con become:true le damos permisos para que pueda instalarlos.

La forma para instalar las gemas es la siguiente:
 
 - gem: indicamos que es una gema
 - name: indicamos el nombre de la gema que queremos instalar y con state: latest igual que con los paquetes , que sea la última versión. Para instalar las gemas no es necesario darle permisos con become
 
 La forma para clonar el repositorio:
 
 - git : repo= direccion del repositorio que vamos a clonar dest= carpeta de nuestra máquina virtual donde lo vamos a clonar. 

La forma para actualizar paquetes:

- apt: utilizado para actualizar paquetes , con update_cache: yes lo que realmente se ejecuta es apt-get update. Le tenemos que dar permisos con become
 

Lo ejecutamos con:

	vagrant provision
	
Captura de pantalla del porceso realizado con ansible:

![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/ansible.png) 

![](https://github.com/juanmaLC/ProyectoIV/blob/master/docs/imagenes/ansible2.png) 

	
Para su configuración me he basado en :

[Ansible+Vagrant](https://www.vagrantup.com/docs/provisioning/ansible.html) 

[Using Vagrant and Ansible](https://docs.ansible.com/ansible/latest/scenario_guides/guide_vagrant.html)

[Ansible Doc](https://docs.ansible.com/ansible/latest/) 

[Ansible sin sudo](https://docs.ansible.com/ansible/2.4/become.html)

[Instalación de las gemas](https://docs.ansible.com/ansible/latest/modules/gem_module.html) 


# Despliegue de la máquina 

Finalmente una vez tenemos la máquina creada con el aprovisionamiento realizado correctamente pasamos al despliegue del microservicio.


Para el despliegue de la máquina me he decantado por el uso de fabric. He preferido usar fabric en lugar de Capistrano , que es específico de ruby , porque me resultaba muy sencilla la forma de implemetar el fichero fabfile . Tenía una documentación clara y solo era definir una funciones que realizasen lo que yo necesitaba, además de que ya tenía cierta idea de como funcionaba fabric.


Mi archivo de configuracion del despliegue es :
[fabfile.py](https://github.com/juanmaLC/ProyectoIV/blob/master/despliegue/fabfile.py) 


	from fabric.api import run



	def BorrarCodigo():
		run("rm -rf ProyectoIV")


	def ClonarCodigo():
		run("git clone https://github.com/juanmaLC/ProyectoIV.git")

	def IniciarMongoDB():
		run("sudo systemctl start mongodb")

	def DetenerMongoDB():
		run("sudo systemctl stop mongodb")

	def InstalarMicroservicio():
		run("cd ProyectoIV/ && bundle install")

	def IniciarMicroservicio():

		#Para que siempre que iniciemos el servicio la base de datos este operativa
		IniciarMongoDB()
		run ("cd ProyectoIV/ && sudo bundle exec rackup -p 80 --host 0.0.0.0")

	def DetenerMicroservicio():
		#run("")

	def ReiniciarMicroservicio():
		DetenerMicroservicio()
		IniciarMicroservcio()
		

**Configuración del archivo**

- Primeramente hago un import de la api de fabric , para poder usar la funcion run("") , que sirve para ejecutar el comando especificado entre comillas en el servidor al que nos conectamos.
- La funcion BorrarCodigo() borra la carpeta ProyectoIV/ de la máquina.
- La función ClonarCodigo() clona el repositorio git indicado . Pensé que los archivos del microservicio en un futuro se podrían actualizar o que los que hay instalados se corrompan , por eso implemente estas dos funciones para permitir al usuario que en algun caso de estos pueda volver a restaurar los ficheros del servicio.
- La funcion IniciarMongoDB() inicia la base de datos del microservicio
- La función DetenerMongoDB() para la ejecución de la base de datos del servicio
- La función InstalarMicroservicio() nos instala el microservicio mediante la ejecución del Gemfile.
- La función IniciarMicroservicio() llama a la función iniciarMongoDB() para asegurarse de que la base de datos esté arrancada y lanza el proceso del microservcio en el puerto 80 y host 0.0.0.0
- La función DetenerMicroservicio() debería de para el proceso del microservicio . Para implementarla estuve buscando información de como encontrar el PID del porceso para luego "matarlo" pero la solución que encontré había veces que al ejecutarla me daba un error y no me quedaba muy claro su uso , por dicha razón opté por dejarlo en blanco.
- La función ReinicarMicroservicio() reinicia el servicio ofrecido , deteniendolo primero y volviendolo a iniciar. Como hace uso de detenerMicroservicio no tiene uso al no tener DetenerMicroservicio() implementado.


La ejecución de estas funciones de despliegue es muy sencilla , por ejemplo, con el comando (iniciamos el microservicio):

	fab -f despliegue/fabfile.py -H vagrant@proyectoivgym.westeurope.cloudapp.azure.com IniciarMicroservicio
	
- f : indicamos donde está nuestro fichero fabfile.py con las funciones definidas
- H : indicamos el usuario y host al que nos vamos a conectar
- Finalmente indicamos el nombre de la función que queremos ejecutar en la máquina a la que nos vamos a conectar.

Para llegar a esta configuración me he basado en:

[Tutorial fabric](http://docs.fabfile.org/en/1.14/tutorial.html#making-connections)

[Variables de entorno fabric (env)](http://docs.fabfile.org/en/1.14/usage/env.html)

[Ruby-Dev](https://stackoverflow.com/questions/13767725/unable-to-install-gem-failed-to-build-gem-native-extension-cannot-load-such)

[Ejecucion de las funciones creadas](http://docs.fabfile.org/en/1.14/usage/execution.html)

[Instalacion de ruby-dev](https://stackoverflow.com/questions/44901379/gemextbuilderror-error-failed-to-build-gem-native-extension-for-rails-vers)


