#!/bin/bash

set -e

echo PATH = $PATH
echo vessel @ `which vessel`

ALICE_HOME=$(mktemp -d -t alice-XXXXXXXX)
BOB_HOME=$(mktemp -d -t alice-XXXXXXXX)
HOME=$ALICE_HOME

dfx start --background
dfx canister create --all
dfx build
dfx canister install --all

ALICE_PUBLIC_KEY=$( \
    HOME=$ALICE_HOME dfx canister call WhoAmI whoami \
        | awk -F '"' '{printf $2}' \
)
BOB_PUBLIC_KEY=$( \
    HOME=$BOB_HOME dfx canister call WhoAmI whoami \
        | awk -F '"' '{printf $2}' \
)

echo
echo == Initial token balances for Alice and Bob.
echo

echo Alice = $( \
    eval dfx canister call Token balanceOf "'(\"$ALICE_PUBLIC_KEY\")'" \
)
echo Bob = $( \
    eval dfx canister call Token balanceOf "'(\"$BOB_PUBLIC_KEY\")'" \
)

echo
echo == Transfer 42 tokens from Alice to Bob.
echo

eval dfx canister call Token transfer "'(\"$BOB_PUBLIC_KEY\", 42)'"

echo
echo == Final token balances for Alice and Bob.
echo

echo Alice = $( \
    eval dfx canister call Token balanceOf "'(\"$ALICE_PUBLIC_KEY\")'" \
)
echo Bob = $( \
    eval dfx canister call Token balanceOf "'(\"$BOB_PUBLIC_KEY\")'" \
)
