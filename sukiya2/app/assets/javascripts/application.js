// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {

  $('.form-delete').click(function(){
    if(!confirm('本当に削除しますか？')){
        /* キャンセルの時の処理 */
        return false;
    }else{
        /*　OKの時の処理 */
        return true;
    }
});

  var number;
  $(function(){
    number = $('input:checked').val();
    $('input').click(function(){
      if($(this).val() == number) {
          $(this).prop('checked', false);
          number = 0;
      } else {
          number = $(this).val();
      }
    });
  });


  $(function(){
    $('#open-menus').click(function(){
      if($('#hide-header').css('display') == 'none') {
        $(`#hide-header`).slideDown();
        $('#hide-header').css('display', 'block');
      } else {
        // $(`#hide-header`).slideUp();
        $('#hide-header').slideUp('fast', function() {
          $('#hide-header').css('display', 'none');
        });
      }
    });
  });

  $(function(){
    $('#mon-shift-menu-down').click(function(){
      if($('#mon-menu').css('display') == 'none') {
        $('#mon-menu').slideDown();
        $('#mon-menu').css('display', 'block');
        $('#mon-shift-menu-down').css('transform', 'scale(1, -1)');
      } else {
        $('#mon-menu').slideUp('fast', function(){
          $('#mon-menu').css('display', 'none');
        });
        $('#mon-shift-menu-down').css('transform', 'scale(1, 1)');
      }
    });
  });
  $(function(){
    $('#tue-shift-menu-down').click(function(){
      if($('#tue-menu').css('display') == 'none') {
        $('#tue-menu').slideDown();
        $('#tue-menu').css('display', 'block');
        $('#tue-shift-menu-down').css('transform', 'scale(1, -1)');
      } else {
        $('#tue-menu').slideUp('fast', function(){
          $('#tue-menu').css('display', 'none');
        });
        $('#tue-shift-menu-down').css('transform', 'scale(1, 1)');
      }
    });
  });
  $(function(){
    $('#wed-shift-menu-down').click(function(){
      if($('#wed-menu').css('display') == 'none') {
        $('#wed-menu').slideDown();
        $('#wed-menu').css('display', 'block');
        $('#wed-shift-menu-down').css('transform', 'scale(1, -1)');
      } else {
        $('#wed-menu').slideUp('fast', function(){
          $('#wed-menu').css('display', 'none');
        });
        $('#wed-shift-menu-down').css('transform', 'scale(1, 1)');
      }
    });
  });
  $(function(){
    $('#thu-shift-menu-down').click(function(){
      if($('#thu-menu').css('display') == 'none') {
        $('#thu-menu').slideDown();
        $('#thu-menu').css('display', 'block');
        $('#thu-shift-menu-down').css('transform', 'scale(1, -1)');
      } else {
        $('#thu-menu').slideUp('fast', function(){
          $('#thu-menu').css('display', 'none');
        });
        $('#thu-shift-menu-down').css('transform', 'scale(1, 1)');
      }
    });
  });
  $(function(){
    $('#fri-shift-menu-down').click(function(){
      if($('#fri-menu').css('display') == 'none') {
        $('#fri-menu').slideDown();
        $('#fri-menu').css('display', 'block');
        $('#fri-shift-menu-down').css('transform', 'scale(1, -1)');
      } else {
        $('#fri-menu').slideUp('fast', function(){
          $('#fri-menu').css('display', 'none');
        });
        $('#fri-shift-menu-down').css('transform', 'scale(1, 1)');
      }
    });
  });
  $(function(){
    $('#sat-shift-menu-down').click(function(){
      if($('#sat-menu').css('display') == 'none') {
        $('#sat-menu').slideDown();
        $('#sat-menu').css('display', 'block');
        $('#sat-shift-menu-down').css('transform', 'scale(1, -1)');
      } else {
        $('#sat-menu').slideUp('fast', function(){
          $('#sat-menu').css('display', 'none');
        });
        $('#sat-shift-menu-down').css('transform', 'scale(1, 1)');
      }
    });
  });
  $(function(){
    $('#sun-shift-menu-down').click(function(){
      if($('#sun-menu').css('display') == 'none') {
        $('#sun-menu').slideDown();
        $('#sun-menu').css('display', 'block');
        $('#sun-shift-menu-down').css('transform', 'scale(1, -1)');
      } else {
        $('#sun-menu').slideUp('fast', function(){
          $('#sun-menu').css('display', 'none');
        });
        $('#sun-shift-menu-down').css('transform', 'scale(1, 1)');
      }
    });
  });

  $(function(){
    $('#confirm').click(function(){

      $('.overlay').addClass('is-open');
      $('#confirm-window').css('display', 'table');

      var mon = [];
      var tue = [];
      var wed = [];
      var thu = [];
      var fri = [];
      var sat = [];
      var sun = [];

      $(':radio:checked').each(function(){
        if($(this).attr('name').match('mon') == 'mon') {
          mon.push($(this).val());
        } else if($(this).attr('name').match('tue') == 'tue'){
          tue.push($(this).val());
        } else if($(this).attr('name').match('wed') == 'wed'){
          wed.push($(this).val());
        } else if($(this).attr('name').match('thu') == 'thu'){
          thu.push($(this).val());
        } else if($(this).attr('name').match('fri') == 'fri'){
          fri.push($(this).val());
        } else if($(this).attr('name').match('sat') == 'sat'){
          sat.push($(this).val());
        } else if($(this).attr('name').match('sun') == 'sun'){
          sun.push($(this).val());
        }
      });

      if(mon.length != 0) {
        // $('.shift-sending-item').css('display', 'none');
        $('#mon').text('月曜日: ' + mon);
      } else {
        $('#mon').text('月曜日: ');
      }
      if(tue.length != 0) {
        $('#tue').text('火曜日: ' + tue);
      } else {
        $('#tue').text('火曜日: ');
      }
      if(wed.length != 0) {
        $('#wed').text('水曜日: ' + wed);
      } else {
        $('#wed').text('水曜日: ');
      }
      if(thu.length != 0) {
        $('#thu').text('木曜日: ' + thu);
      } else {
        $('#thu').text('木曜日: ');
      }
      if(fri.length != 0) {
        $('#fri').text('金曜日: ' + fri);
      } else {
        $('#fri').text('金曜日: ');
      }
      if(sat.length != 0) {
        $('#sat').text('土曜日: ' + sat);
      } else {
        $('#sat').text('土曜日: ');
      }
      if(sun.length != 0) {
        $('#sun').text('日曜日: ' + sun);
      } else {
        $('#sun').text('日曜日: ');
      }

    });
  });

  $(function(){
    $('#confirm-delete').click(function(){
      $('.overlay').removeClass('is-open');
      $('#confirm-window').css('display', 'none');
    });
  });

  $(function(){
    $('#shift-delete').click(function(){
      $(':radio:checked').each(function(){
        $(this).prop('checked', false);
      });
      $('#mon').text('月曜日: ');
      $('#tue').text('火曜日: ');
      $('#wed').text('水曜日: ');
      $('#thu').text('木曜日: ');
      $('#fri').text('金曜日: ');
      $('#sat').text('土曜日: ');
      $('#sun').text('日曜日: ');
    });
  });
});
