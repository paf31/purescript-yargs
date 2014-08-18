module.exports = function(grunt) {

  "use strict";

  grunt.initConfig({ 
  
    libFiles: [
      "src/**/*.purs",
      "bower_components/purescript-*/src/**/*.purs"
    ],
    
    clean: ["tmp", "output"],
  
    pscMake: {
      lib: {
        src: ["<%=libFiles%>"]
      },
      examples: {
        src: ["examples/Main.purs", "<%=libFiles%>"]
      }
    },

    dotPsci: ["<%=libFiles%>"],
 
    copy: [
      {
        expand: true,
        cwd: "output",
        src: ["**"],
        dest: "tmp/node_modules/"
      }, {
        src: ["js/index.js"],
        dest: "tmp/index.js"
      }
    ],

    execute: {
      examples: {
	src: "tmp/index.js"
      }
    }      
  });

  grunt.loadNpmTasks("grunt-contrib-copy");
  grunt.loadNpmTasks("grunt-contrib-clean");
  grunt.loadNpmTasks("grunt-execute")
  grunt.loadNpmTasks("grunt-purescript");
 
  grunt.registerTask("test", ["pscMake:examples", "copy", "execute:examples"]);
  grunt.registerTask("make", ["pscMake:lib", "dotPsci"]);
  grunt.registerTask("default", ["clean", "make", "test"]);
};
