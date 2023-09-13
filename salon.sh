#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ JINGER'S SALON ~~~~~\n"

MAIN(){
    if [[ $1 ]]
        then
        echo -e "\n$1"
    fi  
    echo -e "Welcome to Jinger's Salon, how can I help you?\n"
    SERVICES
    
    #check if SERVICE_ID_SELECTED is in services database
    SERVICE_ID_RESULT=$($PSQL "SELECT service_id FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")
    while [[ -z $SERVICE_ID_RESULT ]]
    do
        echo "I could not find that service. What would you like today?"
        SERVICES
    done
    
}

SERVICES(){
  
  SERVICES=$($PSQL "SELECT service_id, service_name FROM services ORDER BY service_id")
    echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
    do
      echo "$SERVICE_ID) $SERVICE_NAME"
    done
  read SERVICE_ID_SELECTED
}
MAIN