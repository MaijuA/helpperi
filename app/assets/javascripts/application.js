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
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

var set_stars = function(form_id, stars) {
    for(i=1; i<=5; i++) {
        if(i <= stars) {
            $('#' + form_id + '_' + i).addClass('on');
        } else {
            $('#' + form_id + '_' + i).removeClass('on');
        }
    }
};

$(function() {
  $('.rating_star').click(function() {
      var star = $(this);
      var form_id = $(this).attr('data-form-id');
      var score = $(this).attr('data-score');
      var post_id = $(this).attr('data-post-id');

      set_stars(form_id, score);

      $('#' + form_id + '_score').val(score);

      $.ajax({
          type: "post",
          url: '../ratings/update',
          data: $('#' + form_id).serialize() +  "&post_id=" + post_id
      });
  });

//$('.star_rating_form').each(function() {
//    var form_id = $(this).attr('id');
//    var stars = $('#' + form_id + '_score').val();
//    set_stars(form_id, stars);
//});
});
