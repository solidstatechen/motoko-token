/**
 * Module     : Token.mo
 * Copyright  : 2020 Enzo Haussecker
 * License    : Apache 2.0 with LLVM Exception
 * Maintainer : Enzo Haussecker <enzo@dfinity.org>
 * Stability  : Experimental
 */

import Array "mo:base/Array";
import AssocList "mo:base/AssocList";
import Error "mo:base/Error";
import Hex "../vendor/motoko-hex/src/Hex";
import List "mo:base/List";
import Option "mo:base/Option";
import Prim "mo:prim";
import Util "../src/Util";

actor Token {

  /**
   * Types
   */

  // The identity of a token owner in a human readable format.
  public type Owner = Text;

  // The identity of a token owner in a machine readable format.
  private type OwnerBytes = [Word8];

  /**
   * State
   */

  // The initializer of this canister.
  private let initializer : Principal = Prim.caller();

  // The total token supply.
  private let N : Nat = 1000000000;

  // The distribution of token balances.
  private stable var balances : AssocList.AssocList<OwnerBytes, Nat> =
    List.make((Util.unpack(initializer), N));

  /**
   * High-Level API
   */

  // Returns the name of the token.
  public query func name() : async Text {
    return "Internet Computer Token";
  };

  // Returns the symbol of the token.
  public query func symbol() : async Text {
    return "ICT";
  };

  // Returns the total token supply.
  public query func totalSupply() : async Nat {
    return N;
  };

  // Returns the token balance of a token owner.
  public query func balanceOf(owner : Owner) : async ?Nat {
    switch (Hex.decode(owner)) {
      case (#ok ownerBytes) {
        return find(ownerBytes);
      };
      case (#err (#msg msg)) {
        throw Error.reject("Parse error: " # msg);
      };
    };
  };

  // Transfers tokens to another token owner.
  public shared {
    caller = caller;
  } func transfer(to : Owner, ammount : Nat) : async Bool {
    switch (Hex.decode(to)) {
      case (#ok receiver) {
        let sender = Util.unpack(caller);
        let balance = Option.get(find(sender), 0);
        if (balance < ammount) {
          return false;
        } else {
          let difference = balance - ammount;
          replace(sender, if (difference == 0) null else ?difference);
          replace(receiver, ?(Option.get(find(receiver), 0) + ammount));
          return true;
        };
      };
      case (#err (#msg msg)) {
        throw Error.reject("Parse error: " # msg);
      };
    };
  };

  /**
   * Utilities
   */

  // Finds the token balance of a token owner.
  private func find(ownerBytes : OwnerBytes) : ?Nat {
    return AssocList.find<OwnerBytes, Nat>(balances, ownerBytes, eq);
  };

  // Replaces the token balance of a token owner.
  private func replace(ownerBytes : OwnerBytes, balance : ?Nat) {
    balances := AssocList.replace<OwnerBytes, Nat>(
      balances,
      ownerBytes,
      eq,
      balance,
    ).0;
  };

  // Tests two token owners for equality.
  private func eq(x : OwnerBytes, y : OwnerBytes) : Bool {
    return Array.equal<Word8>(x, y, func (xi, yi) {
      return xi == yi;
    });
  };
};
