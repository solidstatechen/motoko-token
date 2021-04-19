import Int "mo:base/Int";

actor SupplyPolicy {
  
    var supplyDelta : Int = 0;
    //statically assigning target to 2019 CPI adjusted dollar
    var target : Int = 1005 * 100000;
    //reaction lag set to 30 days at launch. *current ampleforth reaction lag has changed to 10 days
    var reactionLag : Int = 3; // change to 30 when using floats 
    
    var tempRate : Int = 0; 

    //currently when rebase is called the caller must also input the days oracleRate
    public query func rebase(oracleRate : Int) : async Int {
        
        if ((oracleRate > 950) and (oracleRate < 1065)){
            //do nothing
            return 0;

        } else {

            tempRate := oracleRate * 100000;

            //calculate supplyDelta
            supplyDelta := tempRate - target;

            target := target / 100000;
            
            supplyDelta := supplyDelta / target;
            
            //dampen the supply adjustment over # of days
            supplyDelta := supplyDelta/reactionLag;
            
            //returned value is actual value * 10
            return supplyDelta;
        };

    };
  
};
// ?v in motoko means non mandatory return for v
// concat #