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

    $typeahead.on('typeahead:selected', function(e, datum) {
      Turbolinks.visit(datum.url);
    });
  }
}

$(document).ready(search);
$(window).on('page:change', search);

      // // prefetch: {
      // //   url: $typeahead.data('prefetch'),
      // //   ttl: 500
      // // },
