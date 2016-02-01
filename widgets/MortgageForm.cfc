/**
* A cool basic mortgage form for ContentBox
*/
component extends="contentbox.models.ui.BaseWidget" singleton{

	MortgageForm function init(controller){
		// super init
		//super.init(controller);

		// Widget Properties
		setName("MortgageForm");
		setVersion("1.0");
		setDescription("A cool basic mortgage form for ContentBox content objects.");
		setAuthor("Tropicalista");
		setAuthorURL("http://www.tropicalseo.net");
		setIcon( "comment-add.png" );
		setCategory( "Miscellaneous" );
		return this;
	}

	/**
	* The main mortgage form widget
	* @slug.hint The form slug where to render mortgage plan
	*/
	any function renderIt(required string slug){
		var event	= getRequestContext();

		var checked = (event.getValue("ammortamento","") Eq "on") ? "checked" : "";

		// generate comment form
		saveContent variable="mortgageForm"{
			writeOutput('
				#html.startForm(name="mortgageForm",action=arguments.slug,novalidate="novalidate",method="post")#

					#html.hiddenField(name="isSent",value=true)#

					#html.textField( name="balance", label="Importo:", required="required", value=event.getValue("balance",""), class="form-control", labelClass="control-label", groupWrapper="div class=form-group" )#
					#html.textField(name="rate",label="Tasso:",required="required",value=event.getValue("rate",""), class="form-control", labelClass="control-label", groupWrapper="div class=form-group" )#
					#html.textField(name="term",label="Durata:",required="required",value=event.getValue("term",""), class="form-control", labelClass="control-label", groupWrapper="div class=form-group" )#
					<div class="frm-group">
					<label>Frequenza rate:</label>
					<select name="period" class="form-control">
						<option value="12">Mensile</option>
			        	<option value="4">Trimestrale</option>
			        	<option value="2">Semestrale</option>
					</select>
					</div>
					<div class="checkbox">
					  <label>
					    <input type="checkbox" name="ammortamento" #checked#>Visualizza il piano di ammortamento.
					  </label>
					</div>
					<div class="buttons">
						#html.submitButton(name="calcola",value="Calcola")#
					</div>

				#html.endForm()#
			');
		}

		return mortgageForm;
	}

}
