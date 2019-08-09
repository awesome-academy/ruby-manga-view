document.addEventListener('turbolinks:load', function () {
  $(document).ready(function () {
    $('.dropdown-toggle').dropdown();

    $('#image-upload').bind('change', function () {
      var size_in_megabytes = this.files[0].size / 1024 / 1024;
      if (size_in_megabytes > 5) {
        alert(I18n.t('mix.message_warning_thumb_size'));
      }
    });

    $.uploadPreview({
      input_field: '#image-upload',
      preview_box: '#image-preview',
      label_field: '#image-label',
      label_default: I18n.t("mix.label_default"),
      label_selected: I18n.t("mix.label_selected"),
      no_label: false
    });

    var key = '';
    $('.valid-input1').on('keyup', function () {
      if (key.length <= 100) {
        key = $('.valid-input1').val()
      } else {
        $('.valid-input1').val(key)
      }
      var charCount = $.trim($(this).val()).length;
      $('.result1').text(charCount + '/100');
    });

    var key = '';
    $('.valid-input2').on('keyup', function () {
      if (key.length <= 100) {
        key = $('.valid-input2').val()
      } else {
        $('.valid-input2').val(key)
      }
      var charCount = $.trim($(this).val()).length;
      $('.result2').text(charCount + '/100');
    });

    var key = '';
    $('.valid-input3').on('keyup', function () {
      if (key.length <= 2000) {
        key = $('.valid-input3').val()
      } else {
        $('.valid-input3').val(key)
      }
      var charCount = $.trim($(this).val()).length;
      $('.result3').text(charCount + '/2000');
    });
  });

  $(function () {
    $('.upload-image').on('change', function () {
      var preview = document.querySelector('#preview');
      var files = document.querySelector('input[type=file]').files;

      function readAndPreview(file) {

        if (/\.(jpe?g|png|gif)$/i.test(file.name)) {
          var reader = new FileReader();

          reader.addEventListener('load', function () {
            var image = new Image();
            image.width = 472;
            image.title = file.name;
            image.src = this.result;
            preview.appendChild(image);
          }, false);

          reader.readAsDataURL(file);
        }

      }

      if (files) {
        [].forEach.call(files, readAndPreview);
      }
    });
  });

  $('.story-see-footer').show();
  var prevScrollpos = window.pageYOffset;
  window.onscroll = function () {
    var currentScrollpos = window.pageYOffset;
    if (prevScrollpos > currentScrollpos) {
      document.getElementById('nav-scroll').style.bottom = '0';
      $('.story-see-footer').show();
    } else {
      document.getElementById('nav-scroll').style.bottom = '-100px';
    }
    prevScrollpos = currentScrollpos;
  };

  $('.story-item').children('.more-info').hide();
  $('.story-item').children('.more-info').attr("visibility", "hidden");
  $('.story-item').hover(
    function(){
      $(this).children('.more-info').show();
      $(this).children('.more-info').attr("visibility", "visible");
    }, function(){
      $(this).children('.more-info').hide();
      $(this).children('.more-info').attr("visibility", "hidden");
    }
  );
});
