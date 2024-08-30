# PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"


if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    # echo "$1 is number"
    GET_ELEMENT=$($PSQL "SELECT * FROM elements WHERE atomic_number = $1")
    # echo "$GET_ELEMENT"
    if [[ -z $GET_ELEMENT ]]
    then
      echo "I could not find that element in the database."
    else
      # echo "there is element"
      ELEMENT_INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number = $1")
      echo "$ELEMENT_INFO" | while read TYPE_ID BAR ATOMIC_NO BAR SYMBOL BAR NAME BAR MELTING_POINT BAR BOILING_POINT BAR ATOMIC_MASS BAR TYPE
      do
        echo "The element with atomic number $ATOMIC_NO is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi
  else
    # echo "$1 is char with length ${#1}"
    # "${#str}" -gt 6  ${#detect} -gt 8
    CHAR_LENGTH=${#1}
    if [[ $CHAR_LENGTH > 2 ]]
    then
      # echo "$1 is greater than 2"
      GET_ELEMENT=$($PSQL "SELECT * FROM elements WHERE name = '$1'")
      if [[ -z $GET_ELEMENT ]]
      then
        echo "I could not find that element in the database."
      else
        ELEMENT_INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE name = '$1'")
        echo "$ELEMENT_INFO" | while read TYPE_ID BAR ATOMIC_NO BAR SYMBOL BAR NAME BAR MELTING_POINT BAR BOILING_POINT BAR ATOMIC_MASS BAR TYPE
        do
          echo "The element with atomic number $ATOMIC_NO is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi
    else
      # echo "$1 $CHAR_LENGTH is less than 2"
      GET_ELEMENT=$($PSQL "SELECT * FROM elements WHERE symbol = '$1'")
      if [[ -z $GET_ELEMENT ]]
      then
        echo "I could not find that element in the database."
      else
        ELEMENT_INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE symbol = '$1'")
        echo "$ELEMENT_INFO" | while read TYPE_ID BAR ATOMIC_NO BAR SYMBOL BAR NAME BAR MELTING_POINT BAR BOILING_POINT BAR ATOMIC_MASS BAR TYPE
        do
          echo "The element with atomic number $ATOMIC_NO is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi
    fi
  fi
fi

# SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number = 1