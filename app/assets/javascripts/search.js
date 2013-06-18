$(function() {
  var $typeahead = $('#search');

  if ($typeahead.length > 0) {
    $typeahead.typeahead({
      name: 'items',
      prefetch: {
        url: $typeahead.data('prefetch'),
        ttl: 10
      }
    });

    $typeahead.on('typeahead:selected', function(e, datum) {
      Turbolinks.visit(datum.url);
    });
  }
});
