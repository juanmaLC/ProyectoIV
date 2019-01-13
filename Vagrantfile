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
