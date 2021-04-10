#!/bin/bash

set -e

echo PATH = $PATH
echo vessel @ `which vessel`

dfx start --background
dfx canister create --all
dfx build
dfx canister install --all

eval dfx canister call SupplyPolicy rebase '(2.6423)'
)
