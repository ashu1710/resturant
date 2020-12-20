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
//= require "users/js/jquery-3.3.1.min.js"
//= require "users/js/jquery-ui.min.js"
//= require "users/js/jquery.exitintent.js"
//= require "users/js/exit.js"
//= require "users/js/slick.js"
//= require "users/js/menu.js"
//= require "users/js/lazysizes.min.js"
//= require "users/js/bootstrap.js"
//= require "users/js/bootstrap-notify.min.js"
//= require "users/js/fly-cart.js"
//= require bootstrap-datepicker
//= require jquery.timepicker.js
//= require toastr
//= require jquery.validate
//= require jquery.validate.additional-methods 

$( document ).on('turbolinks:load', function() {
    $('.toggle-nav').on('click', function () {
        $('.sm-horizontal').css("right","0px");
    });
    $(".mobile-back").on('click', function (){
        $('.sm-horizontal').css("right","-410px");
    });

    if ($(window).width() < 1199) {
        $('.mobile_view_cart').removeClass('d-none');
        $('.desktop_view_cart').addClass('d-none');
    }else{
        $('.mobile_view_cart').addClass('d-none');
        $('.desktop_view_cart').removeClass('d-none');

    }
    filter_product();
	loadImage();
	// productDetailsSlick();
	scriptJs();
	formValidate();
    add_to_cart();
    search_product();
    submitbookingform();

    serch_sub_category();
    displayTimeDate();
    menuDisplay();
    loadSlickLoader();
    profileView();
    sentforgetPassword();
    
});

function serch_sub_category(){

    $('.address_btn').on('click', function(e){
        $('.address_forrm').validate();
    });
    $('.btn_search_sub_category').on('click', function(e){
        var searched_text = $('.search_box').val().toLowerCase();
        var is_found = false;
        if(searched_text.length > 0){
            $('.sub_category_details').each(function(e){
                var category_name = $(this).find('h2').text().toLowerCase();
                if(category_name.indexOf(searched_text) != -1){
                    is_found = true;
                    $(this).removeClass('d-none');
                }else{
                    $(this).addClass('d-none');
                }
            });
            if(is_found){
                $('.no_category_found').addClass('d-none');
            }else{
                $('.no_category_found').removeClass('d-none');
            }

        }else{
            $('.sub_category_details').removeClass('d-none');
            $('.no_category_found').addClass('d-none');
        }
    });
}

function sentforgetPassword(){
    $('.formatag').on('click', function(e){
        $('.forget_password_form').removeClass('d-none');
    });

    $('.bnt-change-password-form').on('click', function(e){
        $('.change_password_form').validate({
            rules: {
                'user[password]': {
                    required: true,
                    minlength: 6
                },
                'user[password_confirmation]': {
                    equalTo: "#user_password"
                }
            },
            messages: {
                'user[password_confirmation]': "Enter Confirm Password Same as Password"
            }
        })
    });
}

function submitbookingform(){
    $('.booking_submit').on('click', function(e){
        if($('#booking_booking_date').val() == ''){
            $('.booking_error').removeClass('d-none');
            e.preventDefault();
        }else{
            $('.booking_error').addClass('d-none');
        }
    });

    $('.buynowbtn').click(function(e){
        var color_ids = [];
        var size_ids = [];
        if($('.color_ids:checked').length > 0){
            $('.color_ids:checked').each(function(){
                color_ids.push($(this).val());
            });
        }
        if($('.size_ids:checked').length > 0){
            $('.size_ids:checked').each(function(){
                size_ids.push($(this).val());
            });
        }
        if(color_ids.length == 0 || size_ids.length == 0 ){
            if(size_ids.length == 0){
                toastr.error("Please Select Size");
            }else{
                toastr.error("Please Select Color");
            }
            e.preventDefault();
        }
    })
}


function filter_product(){
    $('.city_filter, .area_filter, .price_sort').on('change', function(e){
        var cityId = $('.city_filter').val(); 
        var areaId = $('.area_filter').val(); 
        var sortType = $('.price_sort').val(); 
        var categoryId = $('#category_id').val(); 
        var subCategoryId = $('#sub_category_id').val(); 
        $.ajax({
            url: "/product_filter",
            type: "get",
            dataType: 'script',
            data: { city_id: cityId, area_id: areaId, sort_type: sortType, category_id: categoryId, sub_category_id: subCategoryId }
        });
    });


    $('.size_id_checkbox, .color-selector li').on('change click', function(e){
        var size_id = [];
        $('.color-selector li').removeClass('active');
        $(this).toggleClass('active');
        var color_id = $('.color-selector li.active').attr('data-value');
        var subCategoryId = $('#sub_category_id').val(); 
        if($('.size_id_checkbox:checked').length > 0){
            $('.size_id_checkbox:checked').each(function(e){
                size_id.push($(this).val());
            });
        }
        $.ajax({
            url: "/product_sub_filter",
            type: "get",
            dataType: 'script',
            data: { size_id: size_id.join(","), color_id: color_id, sub_category_id: subCategoryId }
        });
        e.stopImmediatePropagation();
    });

    $('.sidebar-popup').on('click', function(e) {
        $('.open-popup').toggleClass('open');
        $('.collection-filter').css("left","-15px");
    });
    $('.filter-btn').on('click', function(e) {
        $('.collection-filter').css("left","-15px");
    });
    $('.filter-back').on('click', function(e) {
        $('.collection-filter').css("left","-365px");
        $('.sidebar-popup').trigger('click');
    });

    $('.account-sidebar').on('click', function(e) {
        $('.dashboard-left').css("left","0");
    });
    $('.filter-back').on('click', function(e) {
        $('.dashboard-left').css("left","-365px");
    });

}

function formValidate(){
	if($('.login-form').length > 0){
		$('.login-form').validate();
	}

    $('.forget-password-btn').click(function(e){
        $('.forget_password_form').validate();
    });
}

function loadImage(){
    $('.toggle-nav').on('click', function () {
        $('.sm-horizontal').css("right","0px");
    });
    $(".mobile-back").on('click', function (){
        $('.sm-horizontal').css("right","-410px");
    });

	if($('.bg-img').length > 0){
		$(".bg-top" ).parent().addClass('b-top');
		$(".bg-bottom" ).parent().addClass('b-bottom');
		$(".bg-center" ).parent().addClass('b-center');
		$(".bg_size_content").parent().addClass('b_size_content');
		$(".bg-img" ).parent().addClass('bg-size');
		$(".bg-img.blur-up" ).parent().addClass('blur-up lazyload');

		$('.bg-img').each(function() {

		    var el = $(this),
		        src = el.attr('src'),
		        parent = el.parent();

		    parent.css({
		        'background-image': 'url(' + src + ')',
		        'background-size': 'cover',
		        'background-position': 'center',
		        'display' : 'block'
		    });
		    el.hide();
		});
	}
}

function productDetailsSlick(){
	if($('.product-right-slick').length > 0 && $('.slider-right-nav').length > 0){
	    $('.product-right-slick').slick({
	        slidesToShow: 1,
	        slidesToScroll: 1,
	        arrows: true,
	        fade: true,
	        asNavFor: '.slider-right-nav'
	    });
	    if ($(window).width() > 575) {
	        $('.slider-right-nav').slick({
	            vertical: true,
	            verticalSwiping: true,
	            slidesToShow: 3,
	            slidesToScroll: 1,
	            asNavFor: '.product-right-slick',
	            arrows: false,
	            infinite: true,
	            dots: false,
	            centerMode: false,
	            focusOnSelect: true
	        });
	    }else{
	        $('.slider-right-nav').slick({
	            vertical: false,
	            verticalSwiping: false,
	            slidesToShow: 3,
	            slidesToScroll: 1,
	            asNavFor: '.product-right-slick',
	            arrows: false,
	            infinite: true,
	            centerMode: false,
	            dots: false,
	            focusOnSelect: true,
	            responsive: [
	                {
	                    breakpoint: 576,
	                    settings: {
	                        slidesToShow: 3,
	                        slidesToScroll: 1
	                    }
	                }
	            ]
	        });
	    }
	}
}

function displayTimeDate(){
	if($('.form-row .date').length > 0)
	{
	 	$('.form-row .time').timepicker({
	        'showDuration': true,
	        'timeFormat': 'g:ia'
	    });

	    $('.form-row .date').datepicker({
	        'format': 'd/mm/yyyy',
            'startDate': '-0m'
	    });
	}
}

function menuDisplay(){

	if ($(window).width() > '1200') {
        $('#hover-cls').hover(
            function () {
                    $('.sm').addClass('hover-unset');
            }
        )

    }
    if ($(window).width() > '1200') {
        $('#sub-menu > li').hover(
            function () {
                if($(this).children().hasClass('has-submenu')) {
                    $(this).parents().find('nav').addClass('sidebar-unset');
                }
            },
            function(){
                $(this).parents().find('nav').removeClass('sidebar-unset');
            }
        )
    }
    if($('#main-menu').length > 0){
	    $('#main-menu').smartmenus({
	        subMenusSubOffsetX: 1,
	        subMenusSubOffsetY: -8
	    });
	    $('#sub-menu').smartmenus({
	        subMenusSubOffsetX: 1,
	        subMenusSubOffsetY: -8
	    });
    }

    function openNav() {
    	document.getElementById("mySidenav").classList.add('open-side');
	}
	function closeNav() {
	    document.getElementById("mySidenav").classList.remove('open-side');
	}

	if ($(window).width() < 1199) {
        $('.header-2 .navbar .sidebar-bar, .header-2 .navbar .sidebar-back, .header-2 .mobile-search img').on('click', function () {
            if ($('#mySidenav').hasClass('open-side')) {
                $('.header-2 #main-nav .toggle-nav').css('z-index', '99');
            } else {
                $('.header-2 #main-nav .toggle-nav').css('z-index', '1');
            }
        });
        $('.sidebar-overlay').on('click', function () {
            $('.header-2 #main-nav .toggle-nav').css('z-index', '99');
        });
        $('.header-2 #search-overlay .closebtn').on('click', function () {
            $('.header-2 #main-nav .toggle-nav').css('z-index', '99');
        });
        $('.layout3-menu .mobile-search .ti-search, .header-2 .mobile-search .ti-search').on('click', function () {
            $('.layout3-menu #main-nav .toggle-nav, .header-2 #main-nav .toggle-nav').css('z-index', '1');
        });
    }

}

function profileView(){
	$('.account_info').on('click', function(e){
		$('.profile').removeClass("d-none");
		$('.last').removeClass("active");
		$('.first').addClass("active");
		$('.order_list').addClass('d-none');
	});

	$('.myorder').on('click', function(e){
		$('.first').removeClass("active");
		$('.last').addClass("active");
		$('.order_list').removeClass("d-none");
		$('.profile').addClass('d-none');
	});
}

function scriptJs(){
    $('.loader-wrapper').fadeOut('slow', function() {
        $(this).remove();
    });
    $('#preloader').fadeOut('slow', function() {
        $(this).remove();
    });

    $(window).on('scroll', function() {
        if ($(this).scrollTop() > 600) {
            $('.tap-top').fadeIn();
        } else {
            $('.tap-top').fadeOut();
        }
    });
    $('.tap-top').on('click', function() {
        $("html, body").animate({
            scrollTop: 0
        }, 600);
        return false;
    });

    /*=====================
     04. Mega menu js
     ==========================*/
    if ($(window).width() > '1200') {
        $('#hover-cls').hover(
            function () {
                    $('.sm').addClass('hover-unset');
            }
        )

    }
    if ($(window).width() > '1200') {
        $('#sub-menu > li').hover(
            function () {
                if($(this).children().hasClass('has-submenu')) {
                    $(this).parents().find('nav').addClass('sidebar-unset');
                }
            },
            function(){
                $(this).parents().find('nav').removeClass('sidebar-unset');
            }
        )
    }


    /*=====================
     05. Image to background js
     ==========================*/
    $(".bg-top" ).parent().addClass('b-top');
    $(".bg-bottom" ).parent().addClass('b-bottom');
    $(".bg-center" ).parent().addClass('b-center');
    $(".bg_size_content").parent().addClass('b_size_content');
    $(".bg-img" ).parent().addClass('bg-size');
    $(".bg-img.blur-up" ).parent().addClass('blur-up lazyload');

    $('.bg-img').each(function() {

        var el = $(this),
            src = el.attr('src'),
            parent = el.parent();

        parent.css({
            'background-image': 'url(' + src + ')',
            'background-size': 'cover',
            'background-position': 'center',
            'display' : 'block'
        });

        el.hide();
    });


    /*=====================
     06. Filter js
     ==========================*/
    $(".filter-button").click(function(){
        $(this).addClass('active').siblings('.active').removeClass('active');
        var value = $(this).attr('data-filter');
        if(value == "all")
        {
            $('.filter').show('1000');
        }
        else
        {
            $(".filter").not('.'+value).hide('3000');
            $('.filter').filter('.'+value).show('3000');
        }
    });

    $("#formButton").click(function(){
        $("#form1").toggle();
    });


    /*=====================
     07. left offer toggle
     ==========================*/
    $(".heading-right h3").click(function(){
        $(".offer-box").toggleClass("toggle-cls");
    });


    /*=====================
     08. toggle nav
     ==========================*/
    $('.toggle-nav').on('click', function () {
        $('.sm-horizontal').css("right","0px");
    });
    $(".mobile-back").on('click', function (){
        $('.sm-horizontal').css("right","-410px");
    });


    /*=====================
     09. footer according
     ==========================*/
    var contentwidth = $(window).width();
    if ((contentwidth) < '750') {
        $('.footer-title h4').append('<span class="according-menu"></span>');
        $('.footer-title').on('click', function () {
            $('.footer-title').removeClass('active');
            $('.footer-contant').slideUp('normal');
            if ($(this).next().is(':hidden') == true) {
                $(this).addClass('active');
                $(this).next().slideDown('normal');
            }
        });
        $('.footer-contant').hide();
    } else {
        $('.footer-contant').show();
    }

    if ($(window).width() < '1183') {
        $('.menu-title h5').append('<span class="according-menu"></span>');
        $('.menu-title').on('click', function () {
            $('.menu-title').removeClass('active');
            $('.menu-content').slideUp('normal');
            if ($(this).next().is(':hidden') == true) {
                $(this).addClass('active');
                $(this).next().slideDown('normal');
            }
        });
        $('.menu-content').hide();
    } else {
        $('.menu-content').show();
    }

    /*=====================
     12. Full slider
     ==========================*/
    if ($(window).width() > 767){
        if($(".full-slider").length > 0){
            var $slider = $(".full-slider");
            $slider.
            on('init', function () {
                mouseWheel($slider);
            }).
            slick({
                dots: true,
                nav: false,
                vertical: true,
                infinite: false });

            function mouseWheel($slider) {
                $(window).on('wheel', { $slider: $slider }, mouseWheelHandler);
            }
            function mouseWheelHandler(event) {
                event.preventDefault();
                var $slider = event.data.$slider;
                var delta = event.originalEvent.deltaY;
                if (delta > 0) {
                    $slider.slick('slickNext');
                } else
                {
                    $slider.slick('slickPrev');
                }
            }
        }
    }
    else{
        if($(".full-slider").length > 0){
            var $slider = $(".full-slider");
            $slider.
            on('init', function () {
                mouseWheel($slider);
            }).
            slick({
                dots: true,
                nav: false,
                vertical: false,
                infinite: false });

            function mouseWheel($slider) {
                $(window).on('wheel', { $slider: $slider }, mouseWheelHandler);
            }
            function mouseWheelHandler(event) {
                event.preventDefault();
                var $slider = event.data.$slider;
                var delta = event.originalEvent.deltaY;
                if (delta > 0) {
                    $slider.slick('slickNext');
                } else
                {
                    $slider.slick('slickPrev');
                }
            }
        }
    }


    /*=====================
     13. slick slider
     ==========================*/
  

     if(('slide-2').length > 0){
        $('.slide-2').slick({
            infinite: true,
            slidesToShow: 2,
            slidesToScroll: 2,
            responsive: [
                {
                    breakpoint: 991,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });
    }

    if($('.slide-3').length > 0){
        $('.slide-3').slick({
            infinite: true,
            speed: 300,
            slidesToShow: 3,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 5000,
            responsive: [
                {
                    breakpoint: 1200,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 767,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });
    }

    if($('.team-4').length > 0){
        $('.team-4').slick({
            infinite: true,
            speed: 300,
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 3000,
            responsive: [
                {
                    breakpoint: 1200,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3
                    }
                },
                {
                    breakpoint: 991,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 586,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 1
                    }
                }
            ]
        });
    }

    if($('.slide-4').length > 0){
        $('.slide-4').slick({
            infinite: false,
            speed: 300,
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 5000,
            responsive: [
                {
                    breakpoint: 1200,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3
                    }
                },
                {
                    breakpoint: 991,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 586,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });
    }

    if($('.product-4').length > 0){
        $('.product-4').slick({
            infinite: true,
            speed: 300,
            slidesToShow: 4,
            slidesToScroll: 4,
            autoplay: true,
            autoplaySpeed: 3000,
            responsive: [
                {
                    breakpoint: 1200,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3
                    }
                },
                {
                    breakpoint: 991,
                    settings: {
                        slidesToShow:2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 420,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });
    }

    if($('.tools-product-4').length > 0){
        $('.tools-product-4').slick({
            infinite: true,
            speed: 300,
            slidesToShow: 4,
            slidesToScroll: 4,
            autoplay: true,
            autoplaySpeed: 5000,
            responsive: [
                {
                    breakpoint: 1200,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3
                    }
                },
                {
                    breakpoint: 767,
                    settings: {
                        slidesToShow:2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 420,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });
    }

    if($('.product_4').length > 0){
        $('.product_4').slick({
            infinite: true,
            speed: 300,
            slidesToShow: 4,
            slidesToScroll: 4,
            autoplay: true,
            autoplaySpeed: 5000,
            responsive: [
                {
                    breakpoint: 1430,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3
                    }
                },
                {
                    breakpoint: 1200,
                    settings: {
                        slidesToShow:2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 991,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3
                    }
                },
                {
                    breakpoint: 768,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 420,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });
    }
    if($('.product-3').length > 0){
        $('.product-3').slick({
            infinite: true,
            speed: 300,
            slidesToShow: 3,
            slidesToScroll: 3,
            autoplay: true,
            autoplaySpeed: 5000,
            responsive: [
                {
                    breakpoint:991,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 420,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });
    }

    if($('.slide-5').length > 0){
        $('.slide-5').slick({
            dots: false,
            infinite: true,
            speed: 300,
            slidesToShow: 5,
            slidesToScroll: 5,
            responsive: [
                {
                    breakpoint: 1367,
                    settings: {
                        slidesToShow: 4,
                        slidesToScroll: 4
                    }
                },
                {
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3,
                        infinite: true
                    }
                },
                {
                    breakpoint: 600,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3
                    }
                },
                {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3
                    }
                }
            ]
        });
    }

    if($('.slide-6').length > 0){
        $('.slide-6').slick({
            dots: false,
            infinite: true,
            speed: 300,
            slidesToShow: 6,
            slidesToScroll: 6,
            responsive: [
                {
                    breakpoint: 1367,
                    settings: {
                        slidesToShow: 5,
                        slidesToScroll: 5,
                        infinite: true
                    }
                },
                {
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 4,
                        slidesToScroll: 4,
                        infinite: true
                    }
                },
                {
                    breakpoint: 767,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3,
                        infinite: true
                    }
                },
                {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                }

            ]
        });
    }

    if($('.brand-6').length > 0){
        $('.brand-6').slick({
            dots: false,
            infinite: true,
            speed: 300,
            slidesToShow: 6,
            slidesToScroll: 6,
            responsive: [
                {
                    breakpoint: 1367,
                    settings: {
                        slidesToShow: 5,
                        slidesToScroll: 5,
                        infinite: true
                    }
                },
                {
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 4,
                        slidesToScroll: 4,
                        infinite: true
                    }
                },
                {
                    breakpoint: 767,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3,
                        infinite: true
                    }
                },
                {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 360,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }

            ]
        });
    }

    if($('.product-slider-5').length > 0){
        $('.product-slider-5').slick({
            dots: false,
            infinite: true,
            speed: 300,
            slidesToShow: 5,
            slidesToScroll: 5,
            responsive: [
                {
                    breakpoint: 1200,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll:3
                    }
                },
                {
                    breakpoint: 991,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 420,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });
    }

    if($('.product-5').length > 0){
        $('.product-5').slick({
            dots: false,
            infinite: true,
            speed: 300,
            slidesToShow: 5,
            slidesToScroll: 5,
            responsive: [
                {
                    breakpoint: 1367,
                    settings: {
                        slidesToShow: 4,
                        slidesToScroll: 4
                    }
                },
                {
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3,
                        infinite: true
                    }
                },
                {
                    breakpoint: 768,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });
    }
    
    if($('.slide-7').length > 0){
        $('.slide-7').slick({
            dots: false,
            infinite: true,
            speed: 300,
            slidesToShow: 7,
            slidesToScroll: 7,
            responsive: [
                {
                    breakpoint: 1367,
                    settings: {
                        slidesToShow: 6,
                        slidesToScroll: 6
                    }
                },
                {
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 5,
                        slidesToScroll: 5,
                        infinite: true
                    }
                },
                {
                    breakpoint: 600,
                    settings: {
                        slidesToShow: 4,
                        slidesToScroll: 4
                    }
                },
                {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3
                    }
                }
                // You can unslick at a given breakpoint now by adding:
                // settings: "unslick"
                // instead of a settings object
            ]
        });
        }
    if($('.slide-8').length > 0){
        $('.slide-8').slick({
            infinite: true,
            slidesToShow: 8,
            slidesToScroll: 8,
            responsive: [

                {
                    breakpoint: 1200,
                    settings: {
                        slidesToShow: 6,
                        slidesToScroll: 6
                    }
                }
            ]
        });
    }

    if($('.center').length > 0){
        $('.center').slick({
            centerMode: true,
            centerPadding: '60px',
            slidesToShow: 3,
            responsive: [
                {
                    breakpoint: 768,
                    settings: {
                        arrows: false,
                        centerMode: true,
                        centerPadding: '40px',
                        slidesToShow: 3
                    }
                },
                {
                    breakpoint: 480,
                    settings: {
                        arrows: false,
                        centerMode: true,
                        centerPadding: '40px',
                        slidesToShow: 1
                    }
                }
            ]
        });
    }

    if($('.product-slick').length > 0){
        $('.product-slick').slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            arrows: true,
            fade: true,
            asNavFor: '.slider-nav'
        });
    }

    if($('.slider-nav').length > 0){
        $('.slider-nav').slick({
            vertical: false,
            slidesToShow: 3,
            slidesToScroll: 1,
            asNavFor: '.product-slick',
            arrows: false,
            dots: false,
            focusOnSelect: true
        });
    }

    if ($(window).width() < 1199) {
        $('.header-2 .navbar .sidebar-bar, .header-2 .navbar .sidebar-back, .header-2 .mobile-search img').on('click', function () {
            if ($('#mySidenav').hasClass('open-side')) {
                $('.header-2 #main-nav .toggle-nav').css('z-index', '99');
            } else {
                $('.header-2 #main-nav .toggle-nav').css('z-index', '1');
            }
        });
        $('.sidebar-overlay').on('click', function () {
            $('.header-2 #main-nav .toggle-nav').css('z-index', '99');
        });
        $('.header-2 #search-overlay .closebtn').on('click', function () {
            $('.header-2 #main-nav .toggle-nav').css('z-index', '99');
        });
        $('.layout3-menu .mobile-search .ti-search, .header-2 .mobile-search .ti-search').on('click', function () {
            $('.layout3-menu #main-nav .toggle-nav, .header-2 #main-nav .toggle-nav').css('z-index', '1');
        });
    }


    /*=====================
     15.Tab js
     ==========================*/
    $("#tab-1").css("display", "Block");
    $(".default").css("display", "Block");
    $(".tabs li a").on('click', function () {
        event.preventDefault();
        $('.tab_product_slider').slick('unslick');
        $('.product-4').slick('unslick');
        $(this).parent().parent().find("li").removeClass("current");
        $(this).parent().addClass("current");
        var currunt_href = $(this).attr("href");
        $('#' + currunt_href).show();
        $(this).parent().parent().parent().find(".tab-content").not('#' + currunt_href).css("display", "none");
        $(".product-4").slick({
            arrows: true,
            dots: false,
            infinite: false,
            speed: 300,
            slidesToShow: 4,
            slidesToScroll: 1,
            responsive: [
                {
                    breakpoint: 1200,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3
                    }
                },
                {
                    breakpoint:991,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 420,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });
    });
    $(".tabs li a").on('click', function () {
        event.preventDefault();
        $('.tab_product_slider').slick('unslick');
        $('.product-5').slick('unslick');
        $(this).parent().parent().find("li").removeClass("current");
        $(this).parent().addClass("current");
        var currunt_href = $(this).attr("href");
        $('#' + currunt_href).show();
        $(this).parent().parent().parent().find(".tab-content").not('#' + currunt_href).css("display", "none");
        var slider_class = $(this).parent().parent().parent().find(".tab-content").children().attr("class").split(' ').pop();
        $(".product-5").slick({
            arrows: true,
            dots: false,
            infinite: false,
            speed: 300,
            slidesToShow: 5,
            slidesToScroll: 1,
            responsive: [
                {
                    breakpoint: 1367,
                    settings: {
                        slidesToShow: 4,
                        slidesToScroll: 4
                    }
                },
                {
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3,
                        infinite: true
                    }
                },
                {
                    breakpoint: 768,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 576,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]

        });
    });



    $("#tab-1").css("display", "Block");
    $(".default").css("display", "Block");
    $(".tabs li a").on('click', function () {
        event.preventDefault();
        $('.tab_product_slider').slick('unslick');
        $('.product-3').slick('unslick');
        $(this).parent().parent().find("li").removeClass("current");
        $(this).parent().addClass("current");
        var currunt_href = $(this).attr("href");
        $('#' + currunt_href).show();
        $(this).parent().parent().parent().parent().find(".tab-content").not('#' + currunt_href).css("display", "none");
        $(".product-3").slick({
            arrows: true,
            dots: false,
            infinite: false,
            speed: 300,
            slidesToShow: 3,
            slidesToScroll: 1,
            responsive: [
                {
                    breakpoint:991,
                    settings: {
                        slidesToShow: 2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 420,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });
    });


    /*=====================
     16 .category page
     ==========================*/
    $('.collapse-block-title').on('click', function(e) {
        e.preventDefault;
        var speed = 300;
        var thisItem = $(this).parent(),
            nextLevel = $(this).next('.collection-collapse-block-content');
        if (thisItem.hasClass('open')){
            thisItem.removeClass('open');
            nextLevel.slideUp(speed);
        }
        else {
            thisItem.addClass('open');
            nextLevel.slideDown(speed);
        }
    });
    $('.color-selector ul li').on('click', function(e) {
        $(".color-selector ul li").removeClass("active");
        $(this).addClass("active");
    });
    //list layout view
    $('.list-layout-view').on('click', function(e) {
        $('.collection-grid-view').css('opacity', '0');
        $(".product-wrapper-grid").css("opacity","0.2");
        $('.shop-cart-ajax-loader').css("display","block");
        $('.product-wrapper-grid').addClass("list-view");
        $(".product-wrapper-grid").children().children().removeClass();
        $(".product-wrapper-grid").children().children().addClass("col-lg-12");
        setTimeout(function(){
            $(".product-wrapper-grid").css("opacity","1");
            $('.shop-cart-ajax-loader').css("display","none");
        }, 500);
    });
    //grid layout view
    $('.grid-layout-view').on('click', function(e) {
        $('.collection-grid-view').css('opacity', '1');
        $('.product-wrapper-grid').removeClass("list-view");
        $(".product-wrapper-grid").children().children().removeClass();
        $(".product-wrapper-grid").children().children().addClass("col-lg-3");

    });
    $('.product-2-layout-view').on('click', function(e) {
        if(!$('.product-wrapper-grid').hasClass("list-view")){
            $(".product-wrapper-grid").children().children().removeClass();
            $(".product-wrapper-grid").children().children().addClass("col-lg-6");
        }
    });
    $('.product-3-layout-view').on('click', function(e) {
        if(!$('.product-wrapper-grid').hasClass("list-view")){
            $(".product-wrapper-grid").children().children().removeClass();
            $(".product-wrapper-grid").children().children().addClass("col-lg-4");
        }
    });
    $('.product-4-layout-view').on('click', function(e) {
        if(!$('.product-wrapper-grid').hasClass("list-view")) {
            $(".product-wrapper-grid").children().children().removeClass();
            $(".product-wrapper-grid").children().children().addClass("col-lg-3");
        }
    });
    $('.product-6-layout-view').on('click', function(e) {
        if(!$('.product-wrapper-grid').hasClass("list-view")){
            $(".product-wrapper-grid").children().children().removeClass();
            $(".product-wrapper-grid").children().children().addClass("col-lg-2");
        }
    });



    $("#ltr_btn").click(function(){
         $('body').addClass('ltr');
        $('body').removeClass('rtl');
    });
    $("#rtl_btn").click(function(){
         $('body').addClass('rtl');
        $('body').removeClass('ltr');
    });
    $(".setting_buttons li").click(function(){
        $(this).addClass('active').siblings().removeClass('active');
    });
    $(".color-box li").click(function(){
        $(this).addClass('active').siblings().removeClass('active');
    });

    // (function() {
    //     $('<div class="sidebar-btn dark-light-btn">' +
    //         '<div class="dark-light">'+
    //         '<div class="theme-layout-version">Dark' +
    //         '</div>' +
    //         '</div>' +
    //         '</div>').appendTo($('body'));
    // })();

    // var body_event = $("body");
    // body_event.on("click", ".theme-layout-version" , function(){
    //     $(this).toggleClass('dark');
    //     $('body').removeClass('dark');
    //     if($('.theme-layout-version').hasClass('dark')){
    //         $('.theme-layout-version').text('Light');
    //         $('body').addClass('dark');
    //     }else{
    //         $('#theme-dark').remove();
    //         $('.theme-layout-version').text('Dark');
    //     }

    //     return false;
    // });


    /*=====================
     22. Menu js
     ==========================*/
    function openNav() {
        document.getElementById("mySidenav").classList.add('open-side');
    }
    function closeNav() {
        document.getElementById("mySidenav").classList.remove('open-side');
    }
    $(function() {
        $('#main-menu').smartmenus({
            subMenusSubOffsetX: 1,
            subMenusSubOffsetY: -8
        });
        $('#sub-menu').smartmenus({
            subMenusSubOffsetX: 1,
            subMenusSubOffsetY: -8
        });
    });


    /*=====================
     23. theme-setting
     ==========================*/
    function openSetting() {
        document.getElementById("setting_box").classList.add('open-setting');
        document.getElementById("setting-icon").classList.add('open-icon');
    }
    function closeSetting() {
        document.getElementById("setting_box").classList.remove('open-setting');
        document.getElementById("setting-icon").classList.remove('open-icon');
    }
    $('.setting-title h4').append('<span class="according-menu"></span>');
    $('.setting-title').on('click', function () {
        $('.setting-title').removeClass('active');
        $('.setting-contant').slideUp('normal');
        if ($(this).next().is(':hidden') == true) {
            $(this).addClass('active');
            $(this).next().slideDown('normal');
        }
    });
    $('.setting-contant').hide();


    /*=====================
     24. add to cart sidebar js
     ==========================*/
    function openCart() {
        document.getElementById("cart_side").classList.add('open-side');
    }
    function closeCart() {
        document.getElementById("cart_side").classList.remove('open-side');
    }
}


/*=====================
 25.Tooltip
 ==========================*/
function loadSlickLoader(){
    $('[data-toggle="tooltip"]').tooltip();
    if($('.slide-1').length > 0){
        $('.slide-1').slick();
    }
    if($('.product-right-slick').length > 0 && $('.slider-right-nav').length > 0){
        $('.product-right-slick').slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            arrows: true,
            fade: true,
            asNavFor: '.slider-right-nav'
        });
        if($('.slider-right-nav').length > 0){
            if ($(window).width() > 575) {
                $('.slider-right-nav').slick({
                    vertical: true,
                    verticalSwiping: true,
                    slidesToShow: 3,
                    slidesToScroll: 1,
                    asNavFor: '.product-right-slick',
                    arrows: false,
                    infinite: true,
                    dots: false,
                    centerMode: false,
                    focusOnSelect: true
                });
            }else{
                if($('.slider-right-nav').length > 0){
                    $('.slider-right-nav').slick({
                        vertical: false,
                        verticalSwiping: false,
                        slidesToShow: 3,
                        slidesToScroll: 1,
                        asNavFor: '.product-right-slick',
                        arrows: false,
                        infinite: true,
                        centerMode: false,
                        dots: false,
                        focusOnSelect: true,
                        responsive: [
                            {
                                breakpoint: 576,
                                settings: {
                                    slidesToShow: 3,
                                    slidesToScroll: 1
                                }
                            }
                        ]
                    });
                }
            }
        }
    }

    if($('.product-4').length > 0){
        $('.product-4').slick({
            infinite: true,
            speed: 300,
            slidesToShow: 3,
            slidesToScroll: 4,
            autoplay: false,
            autoplaySpeed: 3000,
            responsive: [
                {
                    breakpoint: 1200,
                    settings: {
                        slidesToShow: 3,
                        slidesToScroll: 3
                    }
                },
                {
                    breakpoint: 991,
                    settings: {
                        slidesToShow:2,
                        slidesToScroll: 2
                    }
                },
                {
                    breakpoint: 420,
                    settings: {
                        slidesToShow: 1,
                        slidesToScroll: 1
                    }
                }
            ]
        });
    }

    if ($(window).width() > '1200') {
        if($('#hover-cls').length > 0){
            $('#hover-cls').hover(
                function () {
                        $('.sm').addClass('hover-unset');
                }
            )
        }

    }
    if ($(window).width() > '1200') {
        if($('#sub-menu > li').length > 0){
            $('#sub-menu > li').hover(
                function () {
                    if($(this).children().hasClass('has-submenu')) {
                        $(this).parents().find('nav').addClass('sidebar-unset');
                    }
                },
                function(){
                    $(this).parents().find('nav').removeClass('sidebar-unset');
                }
            )
        }
    }
}


function add_to_cart(){
    $('.add_cart').on('click', function(e){
        var color_ids = [];
        var size_ids = [];
        if($('.color_ids:checked').length > 0){
            $('.color_ids:checked').each(function(){
                color_ids.push($(this).val());
            });
        }

        if($('.size_ids:checked').length > 0){
            $('.size_ids:checked').each(function(){
                size_ids.push($(this).val());
            });
        }
        var product_id = $('#product_id').val();
        
        if(color_ids.length == 0 || size_ids.length == 0 ){
            if(size_ids.length == 0){
                toastr.error("Please Select Size");
            }else{
                toastr.error("Please Select Color");
            }
        }else{
            $.ajax({
                url: "/carts/"+product_id+"/add_cart",
                type: "get",
                dataType: 'script',
                data: { size_id: size_ids.join(","), color_id: color_ids.join(",") }
            });
        }
    });
}

function search_product(){
    $('.btn_search').on('click', function(){
        var subCategoryId = $('#sub_category_id').val(); 
        var categoryId = $('#category_id').val(); 
        var searchBox = $('.search_box').val(); 
        $.ajax({
            url: "/product_search",
            type: "get",
            dataType: 'script',
            data: { sub_category_id: subCategoryId, search: searchBox, category_id: categoryId }
        });
    });
}