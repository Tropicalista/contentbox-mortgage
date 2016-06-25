component hint="Mortgage module Configuration"{

	// Module Properties
	this.title 				= "cbMortgageCalculator";
	this.author 			= "Francesco Pepe";
	this.webURL 			= "http://www.francescopepe.com";
	this.description 		= "This is an awesome mortgage module";
	this.version			= "1.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "cbMortgageCalculator";
	this.modelNamespace		= "cbMortgageCalculator";

	function configure(){

		// SES Routes
		routes = [
			// Module Entry Point
			{pattern="/", handler="home",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];

		// Binder Mappings
		binder.map("Mortgage@cbMortgageCalculator").to("#moduleMapping#.models.Mortgage");

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
	}

}