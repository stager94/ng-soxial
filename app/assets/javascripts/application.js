// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.ui.all
//= require jquery.autosize
//= require inputfile
//= require angular.min
//= require angular-sanitize
//= require angular-resource.min
//= require angular-route
//= require angular-infinityscroll
//= require bootstrap
//= require ../angular/app
//= require_tree ../angular
//= require_tree ../templates
//= require jquery.fileupload
//= require jquery.fileupload-angular
//= require underscore
//= require alter.fluidimages


$.fn.serializeObject = function() {
  var o = {};
  var a = this.serializeArray();
  $.each(a, function() {
    if (o[this.name] !== undefined) {
      if (!o[this.name].push) {
        o[this.name] = [o[this.name]];
      }
      o[this.name].push(this.value || '');
    } else {
      o[this.name] = this.value || '';
    }
  });
  return o;
};

(function($) {
  $.simpleFormat = function(str) {
    str = str.replace(/\r\n?/, "\n");
    str = $.trim(str);
    if (str.length > 0) {
      str = str.replace(/\n\n+/g, "</p><p>");
      str = str.replace(/\n/g, "<br />");
      str = "<p>" + str + "</p>";
    }
    return str;
  };
 
  $.fn.simpleFormat = function() {
    return this.html($.simpleFormat(this.html()));
  };
 
})(jQuery);