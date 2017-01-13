#!/bin/bash

CASH=999
COST=10

declare -a SYMBOLS=("\033[38;5;172m7" "\033[38;5;1m🍒" "\033[38;5;10m🍏" "\033[38;5;9m🍓" "\033[38;5;92m🍇" "\033[38;5;162m🍉")

slot_machine() {
	local REEL1=$(($RANDOM % ${#SYMBOLS[@]}))
	local REEL2=$(($RANDOM % ${#SYMBOLS[@]}))
	local REEL3=$(($RANDOM % ${#SYMBOLS[@]}))

	local REELS="${SYMBOLS[$REEL1]}${SYMBOLS[$REEL2]}${SYMBOLS[$REEL3]}\033[0m"

	local STATUS="\033[91m-"

	if ( [ $REEL1 -eq $REEL2 ] || [ $REEL2 -eq $REEL3 ] || [ $REEL1 -eq $REEL3 ] ); then
		STATUS="\033[93m±"

		((CASH += $COST))
	fi

	if ( [ $REEL1 -eq $REEL2 ] && [ $REEL2 -eq $REEL3 ] ); then
		PAYOUT=$(($((100 * $(($REEL1 + 1)))) - $COST))

		if [ $REEL1 -eq 0 ]; then
			PAYOUT=$(($((1000 * ${#SYMBOLS[@]})) - $COST))

		fi

		REELS="\033[5m$REELS"
		STATUS="\033[92m+"

		((CASH += $PAYOUT))
	fi

	echo -e "[$REELS] $STATUS\033[32m\$$CASH \033[0m"

	((CASH -= $COST))
}

export PROMPT_COMMAND="$PROMPT_COMMAND ; slot_machine"

