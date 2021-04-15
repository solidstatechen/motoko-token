set -e
echo "cleaning cache"


echo "building prototype"

dfx canister create --all
dfx build 
dfx canister install --all
echo "ready for commands"