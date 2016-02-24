/**
* A cool basic TAEG form for ContentBox
*/
component extends="contentbox.models.ui.BaseWidget" singleton{

	TaegForm function init(controller){
		// super init
		//super.init(controller);

		// Widget Properties
		setName("Taeg");
		setVersion("1.0");
		setDescription("A cool basic mortgage form for ContentBox content objects.");
		setAuthor("Tropicalista");
		setAuthorURL("http://www.tropicalseo.net");
		setIcon( "comment-add.png" );
		setCategory( "Miscellaneous" );
		return this;
	}

	/**
	* The main TAEG form widget
	* @slug.hint The form slug where to render TAEG form
	*/
	any function renderIt(required string slug){
		var event	= getRequestContext();

		var checked = (event.getValue("ammortamento","") Eq "on") ? "checked" : "";

		var periods = [
    		{"value"= 12, "name"= "Mensile"},
    		{"value"= 4, "name"= "Trimestrale"},
    		{"value"= 2, "name"= "Semestrale"}
   		];
		// generate comment form
		saveContent variable="taeg"{
			writeOutput('
				#html.startForm(name="taeg",action=arguments.slug,novalidate="novalidate",method="post")#

					#html.hiddenField(name="isSent",value=true)#

					#html.textField(name="balance", label="Importo:", required="required", value=event.getValue("balance",""), class="form-control", labelClass="control-label", groupWrapper="div class=form-group" )#
					#html.textField(name="rata",label="Rata:",required="required",value=event.getValue("rata",""), class="form-control", labelClass="control-label", groupWrapper="div class=form-group" )#
					#html.textField(name="term",label="Durata:",required="required",value=event.getValue("term",""), class="form-control", labelClass="control-label", groupWrapper="div class=form-group" )#
					<div class="frm-group">
					<label>Frequenza rate:</label>
					#html.select( name="period", class="form-control",options=html.options( values=periods, selectedValue=event.getValue("period","") ) )#
					</div>
					<div class="buttons">
						#html.submitButton(name="calcola",value="Calcola")#
					</div>

				#html.endForm()#
			');
		}

		return taeg;
	}

	/**
	* The TAEG result
	*/
	any function showTaeg(){

		var event	= getRequestContext();
		var rc 		= event.getCollection();

		event.paramValue( "balance", "0" );
		event.paramValue( "rata", "0" );
		event.paramValue( "term", "0" );
		event.paramValue( "period", 12 );
		event.paramValue( "isSent", "false" );

		var errors = [];

		if( rc.isSent ){
			if(!IsNumeric(rc.balance))
				errors.append("L'importo deve essere un numero!");
			if(!IsNumeric(rc.rata))
				errors.append("La rata deve essere un numero!");
			if(!IsNumeric(rc.term))
				errors.append("La durata deve essere un numero!");
			if(!IsNumeric(rc.period))
				errors.append("La frequenza deve essere un numero!");
		}


		if( errors.len() ){
			getInstance( "messagebox@cbMessagebox" ).error( messageArray=errors );
		}
		if( rc.isSent AND !errors.len() ){
			rc.taeg = getInstance( "Mortgage@cbMortgageCalculator" ).calculateTAEG( rc.balance, rc.rata, rc.term, rc.period );
			getInstance("messagebox@cbmessagebox").info("Il TAEG &egrave; #rc.taeg#");
		}	

		return getInstance("messagebox@cbMessagebox").renderit();

	}

}
