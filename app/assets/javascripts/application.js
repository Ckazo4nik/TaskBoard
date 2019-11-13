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
//= require jquery3
//= require popper
//= require bootstrap
//= require bootstrap-datepicker
//= require bootstrap-colorpicker
//= require_tree .

$(document).ready(function() {
  $("#new_project").on("ajax:success", function(event) {
    $(".project-list").html(event.detail[0].attachmentPartial);
    $('.form_create_project').addClass('d-none')
    $('#add_project').removeClass('d-none')
    $(this).find('#title').val('')
  });

});

$(document).ready(function() {
  $("#new_task").on("ajax:success", function(event) {
    $(".task-list").html(event.detail[0].attachmentPartial);
    $('.form_create_task').addClass('d-none')
    $('#add_task').removeClass('d-none')
    $(this).find('#name').val('')
  });

});

$(document).on('click', '#add_project',function() {
    $(this).addClass('d-none');
    $('.form_create_project').removeClass('d-none')
});

$(document).on('click', '#add_task',function() {
    $(this).addClass('d-none');
    $('.form_create_task').removeClass('d-none')
});

$(document).on('click', '.dropdown-item',function() {
  let params = this.id.split('_');
  if(params[1] == 'project') {

    if(params[0] == 'edit'){
      let activated = $('.active');
      if(activated.length > 0) {
        activated.each(function( index ) {
          let params = this.id.split('_');
          $(this).removeClass('d-none active');
          $(`#form_project_${params[1]}`).addClass('d-none');
        });
      }
      $(`#project_${params[2]}`).addClass('d-none active');
      $(`#form_project_${params[2]}`).removeClass('d-none');
    }else {
      $.ajax({
        url: `/projects/${params[2]}`,
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        type: "delete",
        data: {},
      }).done(function() {
        $(`#project_${params[2]}`).hide();
      });
    }
  }else {
    if(params[0] == 'edit'){
      let activated = $('.active');
      if(activated.length > 0) {
        activated.each(function( index ) {
          let params = this.id.split('_');
          $(this).removeClass('d-none active');
          $(`#form_task_${params[1]}`).addClass('d-none');
        });
      }
      $(`#task_${params[2]}`).addClass('d-none active');
      $(`#form_task_${params[2]}`).removeClass('d-none');
    }else if (params[0] == 'delete') {
      $.ajax({
        url: `/tasks/${params[2]}`,
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        type: "delete",
        data: {},
      }).done(function() {
        $(`#task_${params[2]}`).hide();
      });
    }else {
      $.ajax({
        url: `/tasks/${params[2]}/done`,
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        type: "post",
        data: {},
      }).done(function() {
        $(`#task_${params[2]}`).hide();
      });
    }
  }
});

$(document).ready(function(){
  $('.datepicker').datepicker({
    format: "yyyy-mm-dd"
  });
  $('#colorpicker').colorpicker()
});