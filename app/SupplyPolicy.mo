import Debug "mo:base/Debug";

actor SupplyPolicy {
   

    Debug.print("Hello World!");
/*
    // init target var
    public let target : Nat = 0;

    //init change in supply coefficient
    public let supplyDelta : Nat = 0;

    //currently when rebase is called the caller must also input the days oracleRate
    public query func rebase(oracleRate : Nat) : async Bool {

        if (oracleRate < 1.06 & oracleRate > 0.96){
            //do adjustment
            supplyDelta = 0.0;
        } else {
            //statically assigning target to 2019 CPI adjusted dollar
            target = 1.004;
            
            //calculate supplyDelta
            supplyDelta = ((oracleRate - target)/target) * 100;

            //reaction lag set to 30 days at launch. *current ampleforth reaction lag has changed to 10 days
            reactionLag = 30;

            //dampen the supply adjustment over # of days
            supplyDelta = supplyDelta/reactionLag;

        }

        return true;

    };
  */
};
// ?v in motoko means non mandatory return for v
// concat #