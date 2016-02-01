/**
* I am a new Model Object
*/
component singleton{

    property name="messagebox" inject="messagebox@cbMessagebox";

    /*
    * Initialize
    */
    Mortgage function init(){		
        return this;
    }


    /*
    * Monthly rate calculator
    * 
    */
    function calculate( balance, rate, term, period ) {

        var results = {};
        var N = arguments.term * arguments.period;
        var I = (arguments.rate / 100) / arguments.period;
        var v = (1 + I)^N;
        var t = (I * v) / (v - 1);
        var monthlyPayment = arguments.balance * t;
        
        results.monthlyPayment = rounding( monthlyPayment );
        results.total = rounding( (monthlyPayment * arguments.term * arguments.period ) );
        results.totalInterests = rounding( (results.total - arguments.balance ) );
        results.totalInterestsRate = rounding( ( results.totalInterests/results.total ) * 100 );

        return results;

    }

    /*
    * Rounding function
    */ 
    function rounding( required numeric x ){

        return NumberFormat( x, '9.99' );

    }

}
