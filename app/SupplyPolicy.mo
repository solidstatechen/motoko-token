import Int "mo:base/Int";

actor SupplyPolicy {
  
    var supplyDelta : Int = 0;
    //statically assigning target to 2019 CPI adjusted dollar
    var target : Int = 1005;
    //reaction lag set to 30 days at launch. *current ampleforth reaction lag has changed to 10 days
    var reactionLag : Int = 3; // change to 30 when using floats 

    //currently when rebase is called the caller must also input the days oracleRate
    public query func rebase(oracleRate : Int) : async Int {

        //confirm threshold correct
        /*
        if (oracleRate > 960) {
            return 1;
        } else {
            return 2;
        };
*/
        
        if ((oracleRate > 960) and (oracleRate < 1060)){
            //do nothing
            return 3;

        } else {
            
            //calculate supplyDelta
            supplyDelta := oracleRate - target;
            //current calculations allow working with ints 
            supplyDelta := supplyDelta * 100;
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