#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "Select SUM(winner_goals + opponent_goals) AS total_sum From games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "Select AVG(winner_goals) From games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "Select ROUND(AVG(winner_goals), 2) From games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "Select AVG(winner_goals + opponent_goals) From games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "Select MAX(winner_goals) From games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "Select Count(winner_id) From games Where winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "Select name From games Left Join teams ON games.winner_id = teams.team_id Where round='Final' AND year=2018")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "Select DISTINCT t.name From games Join teams t On t.team_id = games.winner_id OR t.team_id = games.opponent_id Where round='Eighth-Final' AND year=2014" ORDER BY t.name)"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "Select Distinct name From games Left join teams On games.winner_id = teams.team_id Order By name")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "Select year, name From games Left Join teams On games.winner_id = teams.team_id Where round='Final' Order By year")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "Select name From teams Where name LIKE 'Co%'")"
