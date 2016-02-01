module.exports = function( grunt ){

	// Default
	grunt.registerTask( "default", [ "compress" ] );

	// Build All
	grunt.registerTask( "all", [ "compress" ] );

	// Config
	grunt.initConfig( {
		// read configs
		pkg : grunt.file.readJSON( "package.json" ),

		// make a zipfile
		compress: {
		  main: {
		    options: {
		      archive: 'cbMortgageCalculator.zip'
		    },
		    files: [
		      {src: ['README.md'], dest: '/cbMortgageCalculator'}, // includes files in path and its subdirs
		      {src: ['ModuleConfig.cfc'], dest: '/cbMortgageCalculator'}, // includes files in path and its subdirs
		      {src: ['handlers/**'], dest: '/cbMortgageCalculator'}, // includes files in path and its subdirs
		      {src: ['models/**'], dest: '/cbMortgageCalculator'}, // includes files in path and its subdirs
		      {src: ['views/**'], dest: '/cbMortgageCalculator'}, // includes files in path and its subdirs
		      {src: ['widgets/**'], dest: '/cbMortgageCalculator'}, // includes files in path and its subdirs
		    ]
		  }
		}

	} );

	// Load Tasks
	require( 'matchdep' )
		.filterDev( 'grunt-*' )
		.forEach( grunt.loadNpmTasks );
};
