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

  var placeholder;
  $('.mc-field-group').each(function() {
    placeholder = $(this).find('label').text();

    if (placeholder !== 'Website ') {
      placeholder = 'Your ' + placeholder;
    }

    $(this).find('input').attr('placeholder', placeholder);
    $(this).find('label').hide();
  });
});

function createCookie(name, value, days) {
    var expires;

    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toGMTString();
    } else {
        expires = "";
    }
    document.cookie = encodeURIComponent(name) + "=" + encodeURIComponent(value) + expires + "; path=/";
}

function readCookie(name) {
    var nameEQ = encodeURIComponent(name) + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) === ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) === 0) return decodeURIComponent(c.substring(nameEQ.length, c.length));
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name, "", -1);
}

function mailchimpFriendly(string) {
  switch(string) {
    case 'fname':
      string = 'forename';
      break;
    case 'lname':
      string = 'surname';
      break;
    case 'mmerge3':
      string = 'website';
      break;
  }

  return string;
}

$(function() {
  var $inputs = $('.guide-form-wrapper form .w-input, #new_marketing_assessment_signup .w-input');
  $inputs.each(function() {
    $(this).val(readCookie(this.name.match(/[^[\]]+(?=])/g)));
  });

  $inputs = $('.mc-field-group input');
  $inputs.each(function() {
    input_name = mailchimpFriendly(this.name.toLowerCase());
    $(this).val(readCookie(input_name));
  });
});

$(document).on('submit', '.guide-form-wrapper form, #new_marketing_assessment_signup', function(e) {
  var $inputs = $('.guide-form-wrapper form .w-input, #new_marketing_assessment_signup .w-input');
  var values = {};
  $inputs.each(function() {
    var input_name = this.name.match(/[^[\]]+(?=])/g);
    createCookie(input_name, $(this).val(), 7);
  });
});
