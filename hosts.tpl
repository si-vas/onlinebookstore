[allservers]
server-1 ansible_host="${server-1}" ansible_connection=ssh ansible_user=ubuntu ansible_port=22 ansible_ssh_private_key_file=/var/lib/jenkins/.ssh/id_rsa

[webserver]
server-1 ansible_host="${server-1}" ansible_connection=ssh ansible_user=ubuntu ansible_port=22 ansible_ssh_private_key_file=/var/lib/jenkins/.ssh/id_rsa
