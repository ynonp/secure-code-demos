$('#btn-compose').on('click', function() {
  $('body').addClass('composing');
});

$('.overlay').on('click', function() {
  $('body').removeClass('composing');
});

$('.contact').on('submit', function() {

  var ok = $('input[name="name"]', this).val().length === 0 ? false
         : $('#select', this).val().length === 0            ? false
         : $('textarea', this).val().length !== 0;

  if ( ok ) {
    var action = $(this).attr('action');
    $.ajax({
      method: 'POST',
      data: $(this).serialize(),
      url: action
    });
    $('body').removeClass('composing');
  } else {
    alert('Missing Info');
  }

  return false;
});