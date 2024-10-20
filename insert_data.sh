#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE games, teams")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != 'year' ]]
  then
    TEAM=$($PSQL "Select name From teams Where name='$WINNER'")
    
    if [[ -z $TEAM ]]
    then
      QUERY_RESULT=$($PSQL "Insert Into teams(name) Values('$WINNER')")
      if [[ $QUERY_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $WINNER
      fi
    fi
    
    TEAM=$($PSQL "Select name From teams Where name='$OPPONENT'")

    if [[ -z $TEAM ]]
    then
      QUERY_RESULT=$($PSQL "Insert Into teams(name) Values('$OPPONENT')")
      if [[ $QUERY_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $OPPONENT
      fi
    fi

    #Getting the winner id
    WINNER_ID=$($PSQL "Select team_id From teams Where name='$WINNER'")
    #Getting the opponent id
    OPPONENT_ID=$($PSQL "Select team_id From teams Where name='$OPPONENT'")

    QUERY_RESULT=$($PSQL "Insert Into games(year, round, winner_goals, opponent_goals, winner_id, opponent_id) Values('$YEAR', '$ROUND', '$WINNER_GOALS', '$OPPONENT_GOALS', '$WINNER_ID', '$OPPONENT_ID')")
    if [[ $QUERY_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into games, $YEAR
    fi
  fi
done
