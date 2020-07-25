## The Token Package

[![Build Status](https://github.com/enzoh/motoko-token/workflows/build/badge.svg)](https://github.com/enzoh/motoko-token/actions?query=workflow%3Abuild)

This package implements a simple ERC-20 style token.

### Prerequisites

- [DFINITY SDK](https://sdk.dfinity.org/docs/download.html) v0.6.0
- [Vessel](https://github.com/kritzcreek/vessel/releases/tag/v0.4.1) v0.4.1 (Optional)

### Usage

Return the name of the token.
```motoko
public query func name() : async Text
```

Return the symbol of the token.
```motoko
public query func symbol() : async Text
```

Return the total token supply.
```motoko
public query func totalSupply() : async Nat
```

Return the token balance of a token owner.
```motoko
public query func balanceOf(owner : Owner) : async ?Nat
```

Transfer tokens to another token owner.
```motoko
public shared func transfer(to : Owner, ammount : Nat) : async Bool
```
