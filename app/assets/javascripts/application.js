// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require vendor/jquery.masonry
//= require vendor/foundation
//= require vendor/foundation.equalizer
//= require vendor/fastclick
//= require vendor/modernizr
//= require vendor/placeholder
//= require vendor/webflow


function setEqualHeight() {
  if (Modernizr.mq('only screen and (min-width: 1024px)')) {
    $('.overflow-hidden').masonry({
      itemSelector: '.article-container, .academy-container'
    });
  }
}

$(function () {
  'use strict';
  $(document).foundation();

  $('.back-to-the-top').click(function(){
    $('html, body').animate({scrollTop: 0},1600);
    return false;
  });

  setEqualHeight();
});