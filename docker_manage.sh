my_menu() {
	echo "Docker Management System.."
	echo -e "1.Start container"
	echo -e "2.Stop container"
	echo -e "3.list all container"
	echo -e "4.exit"
	echo -e "5.launch container"
	echo -e "6.database container"


}

launch_container(){
	echo -e "Enter base OS:"
	read base_os
	echo -e "Enter container name: "
	read cont_name
	echo -e "do you want bash terminal (yes/no): "
	read terminal

	if [[ $terminal == "yes" ]]
	then
		docker run -it  --name  $cont_name  $base_os
	
	else
		docker run -dit --name $cont_name $base_os
		echo "Container : $cont_name launched success.."
	fi 

}

start_container() {

	echo -e "Enter Container name or conatiner id :"
	read container
	docker start $container  && echo "Container $container Started successfully.."   ||  echo "Failed to start the conatiner : $container"

}

stop_container() {
	echo -e "Enter conatiner name or container id :"
	read container
	docker stop $container  &&  echo "Container : $container  stopped"   ||  echo "Container Failed to stop" 


}

list_container() {
	docker ps

}

database_container(){
	echo -e "Enter which service container u want :"
	read image_type
	docker pull $image_type
	echo -e "Enter your container name :"
	read cont_name
	echo -e "Enter root password for database admin : "
	read passwd
	echo -e "do you want the bash terminal (yes/no) :"
	read terminal


	if [[ $terminal == "yes" ]]
	then

		docker run -it  --name $cont_name -e  MYSQL_ROOT_PASSWORD=$passwd $image_type  bash
	
	else

		docker run -dit  --name $cont_name   -e MYSQL_ROOT_PASSWORD=$passwd  $image_type

	fi

}


while :
do
	my_menu
	read -p "Choose an option: " choice
	case $choice in 
		1) start_container ;;
		2) stop_container ;;
		3) list_container ;;
		4) echo "thank you.. for using our service."; exit 0 ;;
		5) launch_container ;;
		6) database_container ;;
		*) echo "invalid oprion";;
	esac

done


