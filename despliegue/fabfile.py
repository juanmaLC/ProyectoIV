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
	run("")

def ReiniciarMicroservicio():
	DetenerMicroservicio()
	IniciarMicroservcio()
	
	

	

