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
//= require jquery
//= require jquery_ujs
//= require popper
//= require turbolinks
//= require bootstrap
//= require ckeditor/init
//= require "js/jquery.scrollTo.min.js"
//= require "js/jquery.nicescroll.js"
//= require "js/owl.carousel.js"
//= require "js/jquery.rateit.min.js"
//= require "js/jquery.customSelect.min.js"
//= require "js/jquery-jvectormap-1.2.2.min.js"
//= require "js/jquery-jvectormap-world-mill-en.js"
//= require "js/xcharts.min.js"
//= require "js/jquery.autosize.min.js"
//= require "js/jquery.placeholder.min.js"
//= require "js/jquery.knob.js"
//= require "js/jquery.slimscroll.min.js"
//= require dataTables/jquery.dataTables
//= require toastr
//= require jquery.validate
//= require jquery.validate.additional-methods 
//= require "js/scripts.js"


  //knob
  $(function() {
    $(".knob").knob({
      'draw' : function () { 
        $(this.i).val(this.cv + '%')
      }
    })
  });

  //carousel
  $(document).ready(function() {
  var wSize = $(window).width();
  if (wSize <= 768) {
    $('#container').addClass("sidebar-closed");
    $('#sidebar').css({
      'margin-left': '-368px'

    });
  }
    removeActiveClass();
    formEditProductForm();
    formEditvendorSignupForm();
    $("#owl-slider").owlCarousel({
      navigation : true,
      slideSpeed : 300,
      paginationSpeed : 400,
      singleItem : true
    });
  });

  $( document ).on('turbolinks:load', function() {
    setSeqNo();
    initializeJS();
    formEditProductForm();
    loadDatatable();
    setArea();
    formEditvendorSignupForm();
    removeActiveClass();
    viewAddress();
    var wSize = $(window).width();
    if (wSize <= 768) {
      $('#container').addClass("sidebar-closed");
      $('#sidebar').css({
        'margin-left': '-368px'

      });
    }
    onAjaxScroll();
  });

  function loadDatatable(){
    $('#dataTables-example').dataTable({
      "ordering": false
    });
  }
  //custom select box

  $(function(){
      $('select.styled').customSelect();
  });
  

function viewAddress(){
  $('.view-address').on('click', function(e){
    $(this).closest('tr').next().toggleClass('hide');
  });
}
function removeAttachment(){
  $('.remove_attachment').on('click', function(e){
    var product_id = "id="+$(this).attr("id");
    $.ajax({
      url: "/products/remove_attachments",
      type: "get",
      dataType: 'script',
      data: product_id,
      error: function(data) {
        toastr.error("Product not found!!!")
      }
    });
  })
}

function setSubCategory(){
  $('#product_category_id').on('change', function(e){
    var category_id = "id="+ $(this).val();
    $.ajax({
      url: "/products/get_sub_category",
      type: "get",
      dataType: 'script',
      data: category_id,
      error: function(data) {
        toastr.error("Sub-category not found!!!")
      }
    });
  });
}

function setArea(){
  $('#admin_city_id').on('change', function(e){
    var area_id = "id="+ $(this).val();
    $.ajax({
      url: "/vendors/get_area",
      type: "get",
      dataType: 'script',
      data: area_id,
      error: function(data) {
        toastr.error("City not found!!!")
      }
    });
  });
}

function removeActiveClass(){
  $('.tab-profile').on('click', function(e){
    $('.tab-profile').closest("li").removeClass("active");
    $(this).closest("li").addClass("active");
  });
}

function form_submit(){
  $('.form-validate.form-horizontal').on('submit', function(e){
    e.preventDefault();
    $('.form-validate.form-horizontal').valid();
  });
}


function validatecategoryForm(){
  if($('.form-validate.form-horizontal').length > 0){
    $('.form-validate.form-horizontal').validate({
      rules: {
          "category[name]": {required: true, maxlength: 80},
        }
    });
    form_submit();
  }
}

function validatesubcategoryForm(){
  if($('.form-validate.form-horizontal').length > 0){
    $('.form-validate.form-horizontal').validate({
      rules: {
          "sub_category[name]": {required: true, maxlength: 80},
        }
    });
    form_submit();
  }
}

function validatebannerForm(){
  if($('.form-validate.form-horizontal').length > 0){
    $('.form-validate.form-horizontal').validate({
      rules: {
          "banner[product_link_redirect]": { required: true,  url: true },
          "banner[banner_image]": { required: true }
        }
    });
    form_submit();
  }
}

function validateNotificationForm(){
  if($('.form-validate.form-horizontal').length > 0){
    $('.form-validate.form-horizontal').validate({
      rules: {
          "notification[msg]": {required: true },
        }
    });
    form_submit();
  }
}

function validateProductForm(){
  if($('.form-validate.form-horizontal').length > 0){
    $('.form-validate.form-horizontal').validate({
      rules: {
          "product[name]": {required: true },
          "product[price]": {required: true },
          "product[description]": {required: true },
          "product[images][]": {required: true },
          "product[category_id]": {required: true }
        }
    });
    form_submit();
  }
}

function formEditProductForm(){
  if($('.form-validate.form-horizontal').length > 0){
    $('.form-validate.form-horizontal').validate({
      rules: {
          "product[name]": {required: true },
          "product[price]": {required: true },
          "product[description]": {required: true },
          "product[category_id]": {required: true }
        }
    });
    form_submit();
  }
}

function checkUserProfieFileType(){
  (function($) {
    $.fn.checkFileType = function(options) {
        var defaults = {
            allowedExtensions: [],
            success: function() {},
            error: function() {}
        };
        options = $.extend(defaults, options);

        return this.each(function() {

            $(this).on('change', function() {
                var value = $(this).val(),
                    file = value.toLowerCase(),
                    extension = file.substring(file.lastIndexOf('.') + 1);

                if ($.inArray(extension, options.allowedExtensions) == -1) {
                    options.error();
                    $(this).focus();
                } else {
                    options.success();

                }

            });

        });
    };
  })(jQuery);

  $(function() {
      $('#product_images').checkFileType({
          allowedExtensions: ['jpg', 'jpeg', 'png'],
          error: function() {
            $('#product_images').val("");
            toastr.error('jpg, jpeg and png file allow');
          }
      });

  });
}


function productImagesCheck(){
  $("#product_images").change(function () {
    var selection = document.getElementById('product_images');  
    var isflag = 0;
    for (var i=0; i<selection.files.length; i++) {
      var file = selection.files[i].name;
      var ext = file.substring(file.lastIndexOf('.') + 1);
      if(ext != "png" && ext != "jpeg" && ext != "jpg")  {
        isflag = 1;
      }
    }
    if(isflag == 1){
      $('#product_images').val("");
      toastr.error('jpg, jpeg and png file allow');
    }
  }); 
}


function formEditProductForm(){
 if($('.changePassword').length > 0){
   $('.changePassword').validate({
      rules: {
          "admin[password]": {
            required: true,
            minlength: 6
          },
          "admin[new_password]": {
            required: true,
            minlength: 6,
            equalTo: "#admin_password" 
          },
        }
    });
 }
  $('.changePassword').on('submit', function(e){
    $('.changePassword').valid();
  });
}

function validateVendorsForm(){
  if($('.form-validate.form-horizontal').length > 0){
    $('.form-validate.form-horizontal').validate({
      rules: {
          "admin[email]": {required: true, maxlength: 80},
          "admin[city_id]": {required: true},
          "admin[area_id]": {required: true},
        }
    });
    form_submit();
  }
}

function formEditvendorSignupForm(){
 if($('.register-vendor').length > 0){
  $('.register-vendor').validate({
      rules: {
          "admin[email]": {
            required: true
          },
          "admin[mobile]": {
            required: true,
            minlength: 10,
            maxlength: 10
          },
          "admin[address]": {
            required: true
          },
          "admin[city_id]": {
            required: true
          },
          "admin[area_id]": {
            required: true
          },
          "admin[password]": {
            required: true,
            minlength: 6
          },
          "admin[password_confirmation]": {
            required: true,
            minlength: 6,
            equalTo: "#admin_password" 
          },
        }
    });
  }
  $('.register-vendor').on('submit', function(e){
    $('.register-vendor').valid();
  });
}

function validatecityForm(){
  if($('.form-validate.form-horizontal').length > 0){
    $('.form-validate.form-horizontal').validate({
      rules: {
          "city[name]": {required: true, maxlength: 80},
        }
    });
    form_submit();  
  }
}


function validateareasForm(){
  if($('.form-validate.form-horizontal').length > 0){
    $('.form-validate.form-horizontal').validate({
      rules: {
          "area[name]": {required: true, maxlength: 80},
        }
    });
    form_submit();
  } 
}

function initializeJS() {

    //tool tips
    $('.tooltips').tooltip();

    //custom scrollbar
        //for html
    $(".row").niceScroll({styler:"fb",cursorcolor:"#007AFF", cursorwidth: '6', cursorborderradius: '10px', background: '#F7F7F7', cursorborder: '', zindex: '1000'});
        //for sidebar
    $("#sidebar").niceScroll({styler:"fb",cursorcolor:"#007AFF", cursorwidth: '6', cursorborderradius: '10px', background: '#F7F7F7', cursorborder: ''});
        // for scroll panel
    $(".scroll-panel").niceScroll({styler:"fb",cursorcolor:"#007AFF", cursorwidth: '3', cursorborderradius: '10px', background: '#F7F7F7', cursorborder: ''});
    
    //sidebar dropdown menu
    $('#sidebar .sub-menu > a').click(function () {
        var last = $('.sub-menu.open', $('#sidebar'));        
        $('.menu-arrow').removeClass('arrow_carrot-right');
        $('.sub', last).slideUp(200);
        var sub = $(this).next();
        if (sub.is(":visible")) {
            $('.menu-arrow').addClass('arrow_carrot-right');            
            sub.slideUp(200);
        } else {
            $('.menu-arrow').addClass('arrow_carrot-down');            
            sub.slideDown(200);
        }
        var o = ($(this).offset());
        diff = 200 - o.top;
        if(diff>0)
            $("#sidebar").scrollTo("-="+Math.abs(diff),500);
        else
            $("#sidebar").scrollTo("+="+Math.abs(diff),500);
    });

    // sidebar menu toggle
    $(function() {
        function responsiveView() {
            var wSize = $(window).width();
            if (wSize <= 768) {
                $('#container').addClass('sidebar-close');
                $('#sidebar > ul').hide();
            }

            if (wSize > 768) {
                $('#container').removeClass('sidebar-close');
                $('#sidebar > ul').show();
            }
        }
        $(window).on('load', responsiveView);
        $(window).on('resize', responsiveView);
    });

    $('.toggle-nav').click(function () {
        if ($('#sidebar > ul').is(":visible") === true) {
            $('#main-content').css({
                'margin-left': '0px'
            });
            var wSize = $(window).width();
            if (wSize <= 768) {
              $('#sidebar').css({
                'margin-left': '-368px'
              });

            }
            else{
              $('#sidebar').css({
                  'margin-left': '-244px'
              });
            }
            $('#sidebar > ul').hide();
            $("#container").addClass("sidebar-closed");
        } else {
            $('#main-content').css({
                'margin-left': '244px'
            });
            $('#sidebar > ul').show();
            $('#sidebar').css({
                'margin-left': '0'
            });
            $("#container").removeClass("sidebar-closed");
        }
    });
}
function onAjaxScroll(){
  $(".row").getNiceScroll().resize();
}

function setSeqNo(){
  $('.vendor_seq_no').click(function(e){
    $('.vendor_seq_no').removeClass('hide');
    $(this).addClass("hide");
    $('.vendor_seq_no_text').addClass("hide");
    $(this).siblings('.vendor_seq_no_text').removeClass("hide");
  });
  $('.set_seq_no_btn').click(function(e){
    var seqNo = $(this).closest('tr').find('#seq_no_vendor').val();
    var vendorId = $(this).closest('tr').attr('class').replace('tr_','');
    $.ajax({
      url: "/vendors/set_seq_no",
      type: "get",
      dataType: 'script',
      data: { seq_no: seqNo, vendor_id: vendorId}
    });
  });
}