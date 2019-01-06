# Despliegue de la máquina en Azure con Vagrant

Para crear la máquina virtual en Azure he utilizado la herramienta Vagrant. 
Con:
	
	vagrant init 
	
Se crea el fichero vagrantfile el cual yo configuré de la siguiente manera:
[Vagrantfile](https://github.com/juanmaLC/ProyectoIV/blob/master/Vagrantfile) 

		# -*- mode: ruby -*-
		# vi: set ft=ruby :

		# All Vagrant configuration is done below. The "2" in Vagrant.configure
		# configures the configuration version (we support older styles for
		# backwards compatibility). Please don't change it unless you know what
		# you're doing.
		Vagrant.configure("2") do |config|


		config.vm.box='azure'
		# Specify SSH key
		config.ssh.private_key_path = '~/.ssh/id_rsa'
	
		#Configuración de valores de azure
		config.vm.provider :azure do |azure, override|

		azure.tenant_id = ENV['AZURE_TENANT_ID']
		azure.client_id = ENV['AZURE_CLIENT_ID']
		azure.client_secret = ENV['AZURE_CLIENT_SECRET']
		azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']
		


		# Specify VM parameters
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
		
**Configuración del archivo**

- config.vm : Configuración de la máquina que Vagrant va a manejar.
- config.vm.box : le indicamos a la maquina que box va a utilizar.
- config.vm.provider : configuración del porveedor , es decir , donde vamos a hostear la maquina.
- azure .vm_name: nombre de la máquina que se va a crear.
- azure.vm.size : tamaño de los recursos de la maquina .
- azure.vm_image_urn : imagen que vamos a instalarle a la máquina.
- azure.resource_group_name: grupo de recursos en el que sera creada la máquina.
- azure.tcp_endpoints : para abrir el puerto 80.
- azure.location: lugar donde queremos el host.
- config.ssh.private_key_path: para especificarle la key para la conexion ssh.
- azure.client_id: id del cliente azure
- azure.subscription_id: id de la suscripción
- azure.client_secret: contraseña del id del cliente
- config.vm.provision : para cargar el archivo de provisión durante el vagrant up


[Documentacion cli vagrant](https://www.vagrantup.com/docs/cli/) 
[Ansible con Vagrant](https://www.vagrantup.com/docs/provisioning/ansible.html) 	
[Configuracion para desplegar maquina azure con vagrant](https://blog.scottlowe.org/2017/12/11/using-vagrant-with-azure/) 
	
Al ejecutar:
	
	vagrant up

Se creará una maquina en nuestro portal de azure con dichas características.

# Provisionamiento de la máquina

Para el provisionamiento de la máquina he utilizado la herramienta ansible.
El archivo de configuración que he utilizado es el siguiente:
[playbook.yml](https://github.com/juanmaLC/ProyectoIV/blob/master/provision/playbook.yml) 

	---
  	- hosts: all
    	sudo: yes
   

    tasks:

      - name: Actualizar paquetes
        apt:
         update_cache: yes

      - name: Ruby
        apt: pkg=ruby state=latest

      


      - name: Clonar el repositorio
        become: yes
        git: repo=https://github.com/juanmaLC/ProyectoIV.git dest=ProyectoIV/ clone=yes force=yes

      

      - gem: 
         name: sinatra
         state: latest

      - gem: 
         name: bundler
         state: latest
      


      - gem: 
         name: rspec
		 state: latest

**Configuración del archivo**
Actualizo todos los paquetes , instalo el paquete de ruby , clono mi repositorio del proyecto e instalo las gemas necesarias.
Lo ejecutamos con:

	vagrant provision
	
Para su configuración me he basado en :
[Ansible+Vagrant](https://www.vagrantup.com/docs/provisioning/ansible.html) 
[Using Vagrant and Ansible](https://docs.ansible.com/ansible/latest/scenario_guides/guide_vagrant.html)
[Ansible Doc](https://docs.ansible.com/ansible/latest/) 
[Instalación de las gemas](https://docs.ansible.com/ansible/latest/modules/gem_module.html) 


# Despliegue de la máquina

Para el despliegue de la máquina me he decantado por el uso de fabric.
Mi archivo de configuracion del despliegue es :
[fabfile.py](https://github.com/juanmaLC/ProyectoIV/blob/master/despliegue/fabfile.py) 


		from __future__ import with_statement
		from fabric.api import *
		from fabric.contrib.console import confirm

		#Lugar y usuario con el que nos vamos a conectar
		env.user='vagrant'
		env.hosts = ['proyectoivgym.westeurope.cloudapp.azure.com']






		def BorrarCodigo():
			run("sudo rm -rf ProyectoIV")


		def ClonarCodigo():
			run("sudo git clone https://github.com/juanmaLC/ProyectoIV.git")

		def InstalarMongoDB():
			run("sudo apt-get install -y mongodb")
			run("sudo systemctl start mongodb")

		def InstalarMicroservicio():
			BorrarCodigo()
			ClonarCodigo()
			InstalarMongoDB()
			run("sudo apt install gcc")
			run("sudo apt install make")
			run("sudo apt install ruby-dev")
			run("sudo gem install bundler")
			run("cd ProyectoIV/ && bundle install")

		def IniciarMicroservicio():
			run ("cd ProyectoIV/ && sudo bundle exec rackup -p 80 --host 0.0.0.0")

**Configuración del archivo**

- env.user= usuario con el que nos vamos a conectar
- env.hosts=lugar donde nos vamos a conectar

He definido 5 funciones que me han parecido utiles:

- BorrarCodigo(): Borra la carpeta clonada de mi repositorio
- ClonarCodigo(): Clona el repositorio indicado en la máquina
- InstalarMongoDB(): instala la base de datos que utiliza el microservicio y la arranca
- InstalarMicroservicio(): Llama a BorrarCodigo() ,ClonarCodigo(), InstalarMongoDB() e instala dependencias(make,gcc,ruby-dev,bundler) para que se puedan instalar todas las gemas necesarias con bundle install.
- IniciarMicroservicio(): Cambia al directorio del proyecto y ejecuta el microservicio en el puerto 80 y en el host 0.0.0.0.


Para llegar a esta configuración me he basado en:
[Tutorial fabric](http://docs.fabfile.org/en/1.14/tutorial.html#making-connections)
[Variables de entorno fabric (env)](http://docs.fabfile.org/en/1.14/usage/env.html)
[Ruby-Dev](https://stackoverflow.com/questions/13767725/unable-to-install-gem-failed-to-build-gem-native-extension-cannot-load-such)
[Ejecucion de las funciones creadas](http://docs.fabfile.org/en/1.14/usage/execution.html)



