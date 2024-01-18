#!/bin/bash

#blackjack--this program takes the popular casino card game and translates it into an interactive bash script. You play against the dealer, trying
# to either beat their score without going over 21, or keep your cool while the dealer goes over 21.

playerPoints=1000 #starting points total for the player to wager with
playerInput="null" #variable used to keep the while loop going and the game running until the player quits

echo
echo "Welcome to Blackjack!" #set of rules are outputted to the player
echo
echo "Here are the rules:"
sleep 2
echo
echo "You begin with 1000 points to wager. At the begin of the round, you'll be asked to wager"
echo "as many points as you'd like. If you win the round, you will recieve double your"
echo "wagered amount in return, but if you lose, you recieve nothing and the points"
echo "you wagered are gone."
echo
echo "Once your wager has been submitted, you will draw a card. In this script,"
echo "cards are simply represented as number values between 1 and 10. The goal"
echo "of the game is to get the highest score you can without exceeding 21. While"
echo "you are drawing cards, the dealer will also be drawing cards, contributing"
echo "to their own score. In order to win, you must beat the dealer's score while"
echo "also not exceeding 21. If the dealer exceeds 21 and you don't, you automatically"
echo "win. If you exceed 21 or the dealer beats your score without exceeding 21,"
echo "you lose. After your first draw, you have the option to hit, stand, or double down."
echo
echo "Hit:"
echo "When you hit, you choose to draw another card to add to your total."
echo
echo "Stand:"
echo "When you stand, you choose to cease drawing any additional turns. Do note that"
echo "the dealer may choose to continue drawing cards even after you stand in an"
echo "attempt to still beat you."
echo
echo "Double Down:"
echo "When doubling down, you choose to not only draw another card, as you would"
echo "when choosing to hit, but you also choose to double your wager. Keep in mind,"
echo "you can't double down if your wager would exceed your current total points."
sleep 10 #sleep keeps these on the screen for 10 seconds before moving on to the game
echo
echo "Ready?"
sleep 2
echo

while [ $(echo $playerInput) != "no" ]; #main while loop that holds the full game and continues running until the user quits
do
	wagerCorrect=0 #variable used to ensure valid wagers are inputted by the player
	dealerConfidence=0 #variable used to keep the dealer from needlessly going over 21
	dealerHand=0 #total value of cards drawn by dealer
	playerHand=0 #total value of cards drawn by player
	while [ $wagerCorrect = 0 ] ; #repeatedly asks for a wager from the player until a valid response is given
	do
		echo -n "Enter a wager: "
		read wager
		if [ ! -z "$(echo $wager |  tr '[:upper:]' '[:lower:]' | sed 's/[0-9]//g')" ] #runs if the wager contains characters other than digits
		then
			echo
			echo "Please only enter numbers for your wager. No \"$\" or commas are necessary."
			echo
		elif [ $wager -le 0 ] #runs if the player tries to wager nothing
		then
			echo
			echo "You must wager more than 0"
			echo
		elif [ $wager -gt $playerPoints ] #runs if the player tries to wager more than they have
		then
			echo
			echo "You only have $playerPoints points. You cannot wager more points than you currently have."
			echo
		else #runs if the wager given is valid
			wagerCorrect=1
			echo
			echo "You have wagered: $wager points."
			sleep 1
			echo
			gameActive=1 #begins the round
		fi
	done
	while [ $gameActive = 1 ] #runs until the round is either won or lost by the player
	do
		echo -n "You draw: "
		sleep 1
		playerDraw=$(( RANDOM % 11 )) #draws a number between 1 and 10
		while [ $playerDraw -eq 0 ] #if the number drawn is 0, this loop runs until it pulls a random number that isn't 0
		do
			playerDraw=$(( RANDOM % 11 ))
		done
		echo $playerDraw #outputs what the player draws
		playerHand=$(( $playerHand + $playerDraw )) #adds the draw to the player's total
		sleep 1
		if [ $dealerConfidence -eq 0 ] #if the dealer's hand is less than 18, they will draw
		then
			echo
			echo -n "The dealer draws: "
			sleep 1
			dealerDraw=$(( RANDOM % 11 )) #draws a number between 1 and 10
			while [ $dealerDraw -eq 0 ] #if the number drawn is 0, this loop runs until it pulls a random number that isn't 0
			do
				dealerDraw=$(( RANDOM % 11 ))
			done
			echo $dealerDraw #outputs what the dealer draws
			dealerHand=$(( $dealerHand + $dealerDraw )) #adds the draw to the dealer's total
			sleep 1
		else #if the dealer's hand is 18 or higher, they will stand
			echo
			echo "The dealer has decided to stand."
			sleep 1
		fi
		echo
		echo "Current Player Total: $playerHand 	Current Dealer Total: $dealerHand" #displays the current totals of the player and the dealer
		sleep 2
		if [ $playerHand -gt 21 ] #ends the round when the player goes over 21
		then
			if [ $dealerHand -le 21 ] #runs if the dealer did not also go over 21, resulting in a loss for the player
			then
				playerPoints=$(( $playerPoints - $wager )) #removes the wager amount from the player's total points
				sleep 1
				echo
				echo "You lose. You exceeded 21."
				sleep 1
				echo
				echo "You lost $wager points"
				sleep 1
				echo
				echo "Your new points total is: $playerPoints"
				sleep 1
				if [ $playerPoints -le 0 ] #runs if the player is out of points to wager with and terminates the script
				then
					echo
					echo "You have no points left to wager..."
					sleep 2
					echo
					echo "GAME OVER"
					sleep 2
					echo
					echo "Thanks for playing!"
					sleep 1
					echo
					exit 0
				else #runs if the player has the choice of continuation
					playerInput="null"
					echo
					echo "Want to keep playing? (yes or no)"
					echo
					while [ $(echo $playerInput) != "yes" ]; #runs as long as the player hasn't decided to continue
					do
						read playerInput
						playerInput="$(echo $playerInput | tr '[:upper:]' '[:lower:]')"
						if [ $(echo $playerInput) = "no" ] #runs if the user decides to end the game and terminates the program
						then
							echo
							echo "Alright, time to cash out. Your final point total was: $playerPoints"
							sleep 2
							echo
							echo "Thanks for playing!"
							sleep 2
							echo
							exit 0
						elif [ $(echo $playerInput) = "yes" ] #ends the loop and starts the player back at the wager loop
						then
							echo
							echo "Okay. Beginning a new round..."
							sleep 3
							gameActive=0
							echo
						else #runs if the response given is invalid
							echo
							echo "Please respond with either \"yes\" or \"no\"."
							echo
						fi
					done
				fi
			else #runs if the dealer also went over 21, resulting in a draw
				echo
				echo "Draw! Both the player and the dealer exceed 21."
				sleep 2
				echo
				echo "Your current points total is: $playerPoints"
				sleep 1
				playerInput="null"
				echo
				echo "Want to keep playing? (yes or no)"
				echo
				while [ $(echo $playerInput) != "yes" ]; #runs as long as the player hasn't decided to continue
				do
					read playerInput
					playerInput="$(echo $playerInput | tr '[:upper:]' '[:lower:]')"
					if [ $(echo $playerInput) = "no" ] #runs if the user decides to end the game and terminates the program
					then
						echo
						echo "Alright, time to cash out. Your final point total was: $playerPoints"
						sleep 2
						echo
						echo "Thanks for playing!"
						sleep 2
						echo
						exit 0
					elif [ $(echo $playerInput) = "yes" ] #ends the loop and starts the player back at the wager loop
					then
						echo
						echo "Okay. Beginning a new round..."
						sleep 3
						gameActive=0
						echo
					else #runs if the response given is invalid
						echo
						echo "Please respond with either \"yes\" or \"no\"."
						echo
					fi
				done
			fi
		else
			if [ $dealerHand -le 21 ] #runs if the user has a hand worth less than 21 and gives them the options on how to continue
			then
				echo
				echo "What will you do next?"
				sleep 1
				validPlayerAction=0
				echo
				echo -n "[Hit, Stand, or Double Down]: "
				while [ $validPlayerAction = 0 ]; #runs a loop until a valid response is given
				do
					read playerAction
					playerAction="$(echo $playerAction | tr '[:upper:]' '[:lower:]' | sed 's/ //g')"
					if [ $(echo $playerAction) = "hit" ] #runs if the player decides they want to draw another card
					then
						if [ $dealerHand -ge 18 ]  #if the dealer has 18 or more in their hand, they will decide to stand
						then                       # to avoid needlessly going over 21 and making it easy for the player
							dealerConfidence=1 # to force the dealer to lose
						fi
						validPlayerAction=1
						echo
					elif [ $(echo $playerAction) = "stand" ] #runs if the player decides they're done drawing cards
					then 
						validPlayerAction=2
					elif [ $(echo $playerAction) = "doubledown" ] #runs if the player wants to draw another card AND
					then                                          # double their bet
						if [ $(( $wager * 2 )) -gt $playerPoints ] #runs to prevent the player's attempt to double
						then                                       # down if such an action would result in them  
							tempInvalidWager=$(( $wager * 2 )) # wagering more points than they actually have
							echo
							echo "You only have $playerPoints points left. Doubling down now would increase"
							echo "your wager to $tempInvalidWager points, and you don't have enough points to"
							echo "cover that bet. Try again and choose either \"Hit\" or \"Stand\"."
							sleep 2
							validPlayerAction=0
							echo
							echo -n "[Hit or Stand]: "
						else #runs if the attempt to double down is successful
							wager=$(( wager * 2 ))
							echo
							echo "You've decided to double down."
							sleep 1
							echo
							echo "Your new wager is: $wager"
							sleep 1
							echo
							validPlayerAction=1
						fi
					else #runs if the action entered is invalid.
						echo
						echo "You've entered an invalid response. Please choose \"Hit\", \"Stand\", or \"Double Down\"."
						sleep 2
						echo
						echo -n "[Hit, Stand, or Double Down]: "
					fi
				done
			else #runs if the player has a hand of 21 or less and the dealer has gone over 21, resulting in a win
				echo
				echo "You win! The dealer exceeded 21."
				sleep 1
				echo
				echo "You won $wager points."
				sleep 1
				playerPoints=$(( $playerPoints + $wager )) #adds the wager winnings to the player's point total
				echo
				echo "Your new points total is: $playerPoints"
				sleep 1
				playerInput="null"
				echo
				echo "Want to keep playing? (yes or no)"
				echo
				while [ $(echo $playerInput) != "yes" ]; #runs as long as the player hasn't decided to continue
				do
					read playerInput
					playerInput="$(echo $playerInput | tr '[:upper:]' '[:lower:]')"
					if [ $(echo $playerInput) = "no" ] #runs if the user decides to end the game and terminates the program
					then
						echo
						echo "Alright, time to cash out. Your final point total was: $playerPoints"
						sleep 2
						echo
						echo "Thanks for playing!"
						sleep 2
						echo
						exit 0
					elif [ $(echo $playerInput) = "yes" ] #ends the loop and starts the player back at the wager loop
					then
						echo
						echo "Okay. Beginning a new round..."
						sleep 3
						gameActive=0
						echo
					else #runs if the response given is invalid
						echo
						echo "Please respond with either \"yes\" or \"no\"."
						echo
					fi
				done
			fi	
		fi
		if [ $validPlayerAction = 2 ] #runs if the player has chosen to stand
		then
			if [ $dealerHand -lt $playerHand ] #runs if the dealer cards in their hand equal a total less than that of the player
			then
				if [ $dealerConfidence -eq 0 ] #runs if the dealer has not already decided to stand
				then
					while [ $dealerHand -lt $playerHand ] #runs as long as the total of dealer's hand is less than the player's
						do
							echo
							echo "The dealer has decided to draw."
							sleep 2
							echo
							echo -n "The dealer draws: "
							sleep 1
							dealerDraw=$(( RANDOM % 11 )) #draws a number between 1 and 10
							while [ $dealerDraw -eq 0 ] #if the number drawn is 0, this loop runs until it pulls a random number that isn't 0
							do
								dealerDraw=$(( RANDOM % 11 ))
							done
							echo $dealerDraw #outputs what the dealer draws
							dealerHand=$(( $dealerHand + $dealerDraw )) #adds the draw to the dealer's total
							echo
							echo "Current Player Total: $playerHand 	Current Dealer Total: $dealerHand" #displays the current totals of the player and the dealer
							sleep 2
						done
				fi
			elif [ $dealerHand -gt $playerHand ] #runs if the player decided to stand despite the dealer having a higher total of cards than them
			then
				if [ $dealerConfidence -eq 0 ] #announces the dealer is standing only if they haven't already
				then
					echo
					echo "The dealer has decided to also stand."
				fi
			else
				if [ $(( 21 - $dealerHand )) -gt 4 ]   #runs if the total of the cards in the dealer's hand is equal to the total of cards in
				then                                   # the player's hand AND the dealer has a total less than 17. In this scenario,
					if [ $dealerConfidence -eq 0 ] # the dealer will draw one last time to try and win, but only if they haven't already	
					then	                       # decided to stand.
						echo "The dealer has decided to draw one more time."
						sleep 2
						echo -n "The dealer draws: "
						sleep 1
						dealerDraw=$(( RANDOM % 11 )) #draws a number between 1 and 10
						while [ $dealerDraw -eq 0 ] #if the number drawn is 0, this loop runs until it pulls a random number that isn't 0
						do
							dealerDraw=$(( RANDOM % 11 ))
						done
						echo $dealerDraw #outputs what the dealer draws
						dealerHand=$(( $dealerHand + $dealerDraw )) #adds the draw to the dealer's total
						echo "Current Player Total: $playerHand 	Current Dealer Total: $dealerHand" #displays the current totals of the player and the dealer
						sleep 2
					fi
				else                                   #runs if the total of the cards in the dealer's hand is equal to the total of cards in
					if [ $dealerConfidence -eq 0 ] # the player's hand AND the dealer has less a total greater than or equal to 17. In this
					then                           #  scenario, the dealer stands and chooses to tie with the player.
						echo "The dealer has decided to also stand."
					fi
				fi
			fi
			if [ $dealerHand -gt 21 ] #runs if the dealer goes over 21, resulting in a win for the player
			then
				echo
				echo "You win! The dealer exceeded 21."
				sleep 1
				echo
				echo "You won $wager points."
				sleep 1
				playerPoints=$(( $playerPoints + $wager )) #adds the wager winnings to the player's point total
				echo
				echo "Your new points total is: $playerPoints"
				sleep 1
				playerInput="null"
				echo
				echo "Want to keep playing? (yes or no)"
				echo
				while [ $(echo $playerInput) != "yes" ]; #runs as long as the player hasn't decided to continue
				do
					read playerInput
					playerInput="$(echo $playerInput | tr '[:upper:]' '[:lower:]')"
					if [ $(echo $playerInput) = "no" ] #runs if the user decides to end the game and terminates the program
					then
						echo
						echo "Alright, time to cash out. Your final point total was: $playerPoints"
						sleep 2
						echo
						echo "Thanks for playing!"
						sleep 2
						echo
						exit 0
					elif [ $(echo $playerInput) = "yes" ] #ends the loop and starts the player back at the wager loop
					then
						echo
						echo "Okay. Beginning a new round..."
						sleep 3
						gameActive=0
						echo
					else #runs if the response given is invalid
						echo
						echo "Please respond with either \"yes\" or \"no\"."
						echo
					fi
				done
			elif [ $dealerHand -lt $playerHand ] #runs if the player scores higher than the dealer without going over 21, resulting in a win
			then
				echo
				echo "You win! You scored more than the dealer without exceeding 21."
				sleep 1
				echo
				echo "You won $wager points."
				sleep 1
				playerPoints=$(( $playerPoints + $wager )) #adds the wager winnings to the player's point total
				echo
				echo "Your new points total is: $playerPoints"
				sleep 1
				playerInput="null"
				echo
				echo "Want to keep playing? (yes or no)"
				echo
				while [ $(echo $playerInput) != "yes" ]; #runs as long as the player hasn't decided to continue
				do
					read playerInput
					playerInput="$(echo $playerInput | tr '[:upper:]' '[:lower:]')"
					if [ $(echo $playerInput) = "no" ] #runs if the user decides to end the game and terminates the program
					then
						echo
						echo "Alright, time to cash out. Your final point total was: $playerPoints"
						sleep 2
						echo
						echo "Thanks for playing!"
						sleep 2
						echo
						exit 0
					elif [ $(echo $playerInput) = "yes" ] #ends the loop and starts the player back at the wager loop
					then
						echo
						echo "Okay. Beginning a new round..."
						sleep 3
						gameActive=0
						echo
					else #runs if the response given is invalid
						echo
						echo "Please respond with either \"yes\" or \"no\"."
						echo
					fi
				done
			elif [ $dealerHand -gt $playerHand ] #runs if the dealer scored higher than the player without going over 21, resulting in a loss for the player
			then
				playerPoints=$(( $playerPoints - $wager )) #removes the wager amount from the player's total points
				sleep 1
				echo
				echo "You lose. The dealer scored more points than you without exceeding 21."
				sleep 1
				echo
				echo "You lost $wager points"
				sleep 1
				echo
				echo "Your new points total is: $playerPoints"
				sleep 1
				if [ $playerPoints -le 0 ] #runs if the player is out of points to wager with and terminates the script
				then
					echo
					echo "You have no points left to wager..."
					sleep 2
					echo
					echo "GAME OVER"
					sleep 2
					echo
					echo "Thanks for playing!"
					sleep 1
					exit 0
				else #runs if the player has the choice of continuation
					playerInput="null"
					echo
					echo "Want to keep playing? (yes or no)"
					echo
					while [ $(echo $playerInput) != "yes" ]; #runs as long as the player hasn't decided to continue
					do
						read playerInput
						playerInput="$(echo $playerInput | tr '[:upper:]' '[:lower:]')"
						if [ $(echo $playerInput) = "no" ] #runs if the user decides to end the game and terminates the program
						then
							echo
							echo "Alright, time to cash out. Your final point total was: $playerPoints"
							sleep 2
							echo
							echo "Thanks for playing!"
							sleep 2
							echo
							exit 0
						elif [ $(echo $playerInput) = "yes" ] #ends the loop and starts the player back at the wager loop
						then
							echo
							echo "Okay. Beginning a new round..."
							sleep 3
							gameActive=0
							echo
						else #runs if the response given is invalid
							echo
							echo "Please respond with either \"yes\" or \"no\"."
							echo
						fi
					done
				fi
			else #runs if the dealer's and player's totals are equal, resulting in a win
				echo
				echo "Draw! Both the player and the dealer tied."
				sleep 2
				echo
				echo "Your current points total is: $playerPoints"
				sleep 1
				playerInput="null"
				echo
				echo "Want to keep playing? (yes or no)"
				echo
				while [ $(echo $playerInput) != "yes" ]; #runs as long as the player hasn't decided to continue
				do
					read playerInput
					playerInput="$(echo $playerInput | tr '[:upper:]' '[:lower:]')"
					if [ $(echo $playerInput) = "no" ] #runs if the user decides to end the game and terminates the program
					then
						echo
						echo "Alright, time to cash out. Your final point total was: $playerPoints"
						sleep 2
						echo
						echo "Thanks for playing!"
						sleep 2
						echo
						exit 0
					elif [ $(echo $playerInput) = "yes" ] #ends the loop and starts the player back at the wager loop
					then
						echo
						echo "Okay. Beginning a new round..."
						sleep 3
						gameActive=0
						echo
					else #runs if the response given is invalid
						echo
						echo "Please respond with either \"yes\" or \"no\"."
						echo
					fi
				done
			fi
		fi	
	done
done
