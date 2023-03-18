#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ $1 ]]
then
  if [[ $1 =~ ^[0-9]+$ ]]
    then
    ELEMENT=$($PSQL "SELECT atomic_number, symbol, elements.name, atomic_mass, melting_point_celsius, boiling_point_celsius, types.type FROM properties JOIN elements USING(atomic_number) JOIN types USING(type_id) WHERE elements.atomic_number=$1")
    else
    ELEMENT=$($PSQL "SELECT atomic_number, symbol, elements.name, atomic_mass, melting_point_celsius, boiling_point_celsius, types.type FROM properties JOIN elements USING(atomic_number) JOIN types USING(type_id) WHERE elements.name='$1' OR elements.symbol='$1' ORDER BY atomic_number")
  fi

  if [[ -z $ELEMENT ]]
  then
    echo "I could not find that element in the database."
    else
    echo "$ELEMENT" | while read AUTOMIC_NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MPC BAR BPC BAR TYPE BAR
    do
    echo -e "The element with atomic number $AUTOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MPC celsius and a boiling point of $BPC celsius."
    done
  fi
  else
  echo -e "Please provide an element as an argument."
fi