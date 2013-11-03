var search = function() {
  var $typeahead = $('#search');

  if ($typeahead.length > 0) {
    $typeahead.typeahead({
      name: 'items',
      remote: {
        url: $typeahead.data('remote'),
        wildcard: 'QUERY'
      },
      footer: $typeahead.data('footer')
    });

    // $typeahead.on('typeahead:selected', function(e, datum) {
    //   Turbolinks.visit(datum.url);
    // });

    $typeahead.on('input', function(e) {
      if ($(window).width() < 600) {
        window.scrollTo(0, $typeahead.offset().top - 10);
      };
    })
  }
}

$(document).ready(search);
$(window).on('page:change', search);
