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
