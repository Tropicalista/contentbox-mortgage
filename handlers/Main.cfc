/**
* Mortgage plan renderer
*/
component{

	property name="mortgage" inject="Mortgage@cbMortgageCalculator";

	function mortgageRender(event,rc,prc){
		
		event.paramValue( "balance", "0" );
		event.paramValue( "rate", "0" );
		event.paramValue( "term", "0" );
		event.paramValue( "period", 12 );
		event.paramValue( "isSent", "false" );

		var errors = [];

		if( rc.isSent ){
			if(!IsNumeric(rc.balance))
				errors.append("L'importo deve essere un numero!");
			if(!IsNumeric(rc.rate))
				errors.append("Il tasso deve essere un numero!");
			if(!IsNumeric(rc.term))
				errors.append("La durata deve essere un numero!");
			if(!IsNumeric(rc.period))
				errors.append("La frequenza deve essere un numero!");
		}


		if( errors.len() ){
			getInstance("messagebox@cbMessagebox").error( messageArray=errors );
		}elseif( rc.isSent ){
			rc.results = mortgage.calculate( rc.balance, rc.rate, rc.term, rc.period );
		}	

		if(structKeyExists(rc, "ammortamento") AND errors.len() LTE 0){
			prc.NumberOfPeriods = rc.term * rc.period;
			prc.CumulativeInterest = 0;
			prc.CumulativePrincipalPaid = 0;
			prc.PreviousBalance = rc.balance;
			prc.monthly_interest = ( rc.rate / 100 ) / rc.period;
		}

		return renderView( view="calculator/index", module="cbMortgageCalculator", cache=false );

	}

}