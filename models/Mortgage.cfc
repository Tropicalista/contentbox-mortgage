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
    */
    function calculate( balance, rate, term, period ) {

        var results = {};
        // calculate payment number
        var N = paymentNumber( arguments.term, arguments.period );
        // calculate interests rate
        var I = (arguments.rate / 100) / arguments.period;
        var v = (1 + I)^N;
        var t = (I * v) / (v - 1);
        
        results.monthlyPayment = arguments.balance * t;
        results.total = rounding( (results.monthlyPayment * arguments.term * arguments.period ) );
        results.totalInterests = rounding( (results.total - arguments.balance ) );
        results.totalInterestsRate = rounding( ( results.totalInterests/arguments.balance ) * 100 );

        return results;

    }

    /*
    * TAEG calculator
    */
    function calculateTAEG( mutuo, rata, anni, periodo ) {

        variables.rapporto = arguments.mutuo / arguments.rata;
        variables.nk = paymentNumber( arguments.anni, arguments.periodo );

        var ik = bisection( 0.00001, 1 ); // bisection algorithm

        var ia = power( ik , arguments.periodo )-1; // calcolo del tasso effettivo annuo

        return rounding( ia * 100 );  //arrotondamento al centesimo

    }

    /*
    * Calculate payment number
    */
    public function paymentNumber( required term, required period ){
        return arguments.term * arguments.period;
    }

    /*
    * Calculate effective rate and compound interests
    */
    function effectiveRate( principal, rate, months, years ) {

        var i = arguments.rate / ( 100 * arguments.months );

        var n = arguments.months * arguments.years;

        result.r1 = round( 100 * arguments.principal * power(i,n)) / 100;

        result.r2 = round( 100000 * power(i,arguments.months) - 100000 ) / 1000;

        return result;
    }

    /*
    * Power function
    */
    function power( i, n ) {

        b = 1 + i;

        w = b^n;

        return w;

    }

    /*
    * Rounding function
    */ 
    function rounding( required numeric x ){

        return NumberFormat( x, '9.99' );

    }


    /*
    * Bisection function
    */ 
    function bisection( a, b ){

        var fa = f( a );

        if( fa EQ 0 ){
          return a;
        };

        var fb = f( b );
        if( fb EQ 0 ) {
          return b;
        };

        var m = ( arguments.a + arguments.b )/2;
        var fm = f( m );
        if ( fm EQ 0 ) {
          return m;
        };
        if ( ( arguments.b - arguments.a ) < 1e - 8 ) {
          return m;
        };
        if ( ( fa * fm ) < 0 ) {
          return bisection( arguments.a, m );
        }else{
          return bisection( m, arguments.b );
        }

    };

    function f( x ){
        return ( 1 - variables.rapporto * arguments.x ) * power( arguments.x, variables.nk )-1;
    }

}
