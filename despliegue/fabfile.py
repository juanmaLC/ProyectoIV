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
	

	

