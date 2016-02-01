/**
* A cool basic commenting form for ContentBox
*/
component extends="contentbox.models.ui.BaseWidget" singleton{

	MortgagePlan function init(controller){
		// super init
		super.init(controller);

		// Widget Properties
		setName("MortgagePlan");
		setVersion("1.0");
		setDescription("A cool basic mortgage plan for ContentBox content objects.");
		setAuthor("Tropicalista");
		setAuthorURL("http://www.tropicalseo.net");
		setIcon( "comment-add.png" );
		setCategory( "Miscellaneous" );
		return this;
	}

	/**
	* The mortgage plan widget
	*/
	any function renderIt(){

		var content = runEvent(event='cbMortgageCalculator:main.mortgageRender', cache=false);

		return content;

	}

}
