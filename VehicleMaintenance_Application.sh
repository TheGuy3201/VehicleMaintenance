#!/bin/bash

#Group 2: Vehicle Maintenance Application
#Joshua Desroches 301350618
#Jamil Ibrahimi 301377159
#Kuan-Wei Han 301287850
#Joyal Joy 301347010
echo "Group2: Vehicle Maintenance Application: Joshua D, Jamil I, Kuan-Wei H, Joyal J"

# Function to add a new vehicle
add_vehicle() {
	clear
	echo "Enter vehicle information:"
	read -p "License Plate: " license_plate
	read -p "Make: " make
	read -p "Model: " model
	read -p "Manufacturer: " manufacturer
	read -p "Owner: " owner
	read -p "Purchase Date: " purchase_date
	read -p "Is it leased? (yes/no): " leased
	read -p "Is it financed? (yes/no): " financed

	# Save vehicle information to a file
	echo "$license_plate|$make|$model|$manufacturer|$owner|$purchase_date|$leased|$financed" >> vehicles.txt
	echo "Vehicle added successfully!"
	echo "Copyright Group2: Vehicle Maintenance Application: Joshua D, Jamil I, Kuan-Wei H, Joyal J"
}

# Function to add a new maintenance task
add_maintenance_task() {
	clear
	echo "Enter maintenance task information:"
	read -p "License Plate: " license_plate
	read -p "Task Name: " task_name
	read -p "Date Performed: " date_performed
	read -p "Total Cost: " total_cost
	read -p "Additional Comments: " comments

	# Save maintenance task information to a file
	echo "$license_plate|$task_name|$date_performed|$total_cost|$comments" >> maintenance_tasks.txt
	echo "Maintenance task added successfully!"
	echo "Copyright Group2: Vehicle Maintenance Application: Joshua D, Jamil I, Kuan-Wei H, Joyal J"

}

# Function to check for maintenance tasks approaching 1 year later
check_maintenance_reminders() {
	current_date=$(date +%s)
	while IFS='|' read -r license_plate task_name date_performed total_cost comments; do
		task_date=$(date -d "$date_performed" +%s)
		diff=$(( (current_date - task_date) / (60*60*24) ))
		if [ $diff -ge 365 ]; then
			echo "Reminder: Maintenance task '$task_name' for vehicle '$license_plate' was performed over a year ago."
		fi
	done < maintenance_tasks.txt
}

# Call the function to check reminders when opening the script
check_maintenance_reminders

# Function to remove a vehicle
remove_vehicle() {
	clear
	read -p "Enter License Plate to remove: " license_plate
	sed -i "/^$license_plate|/d" vehicles.txt
	sed -i "/^$license_plate|/d" maintenance_tasks.txt
	echo "Vehicle removed successfully!"
	echo "Copyright Group2: Vehicle Maintenance Application: Joshua D, Jamil I, Kuan-Wei H, Joyal J"

}

# Function to display all vehicles
display_all_vehicles() {
	clear
	echo "All Vehicles:"
	echo "License Plate | Make | Model | Manufacturer | Owner | Purchase Date | Leased | Financed"
	echo "----------------------------------------------------------------------------------------------"
	cat vehicles.txt
}

# Function to update vehicle information
update_vehicle() {
	clear
	read -p "Enter License Plate to update: " license_plate
	# Check if the vehicle exists
	if grep -q "^$license_plate|" vehicles.txt; then
		# Remove existing entry
		sed -i "/^$license_plate|/d" vehicles.txt
		
		# Add updated information
		echo "Enter updated vehicle information:"
		read -p "Make: " make
		read -p "Model: " model
		read -p "Manufacturer: " manufacturer
		read -p "Owner: " owner
		read -p "Purchase Date: " purchase_date
		read -p "Is it leased? (yes/no): " leased
		read -p "Is it financed? (yes/no): " financed

		# Save updated vehicle information to the file
		echo "$license_plate|$make|$model|$manufacturer|$owner|$purchase_date|$leased|$financed" >> vehicles.txt
		echo "Vehicle information updated successfully!"
	else
		echo "Vehicle not found!"
	fi
}

# Main menu
while true; do
	clear
	echo "Main Menu:"
	echo "1. Add New Vehicle"
	echo "2. Add New Maintenance Task"
	echo "3. Check Maintenance Reminders"
	echo "4. Display All Vehicles"
	echo "5. Update Vehicle Information"
	echo "6. Remove a Vehicle"
	echo "7. Exit"
	read -p "Enter your choice: " choice

	case $choice in
	1) add_vehicle ;;
	2) add_maintenance_task ;;
	3) check_maintenance_reminders ;;
	4) display_all_vehicles ;;
	5) update_vehicle ;;
	6) remove_vehicle ;;
	7) echo "Exiting..."; exit ;;
	*) echo "Invalid choice. Please enter a number between 1 and 7." ;;
	esac




