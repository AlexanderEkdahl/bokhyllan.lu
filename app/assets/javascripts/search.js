suggestion = function (result) {
  var element = document.createElement("a");
  element.setAttribute("href", result.url);
  element.innerHTML = result._highlightResult.name.value;
  return element.outerHTML;
}

var search = function() {
  var $typeahead = $('#search');

  if ($typeahead.length > 0) {
    $typeahead.typeahead({
      name: 'items',
      remote: algolia_client.initIndex($typeahead.data('index')).getTypeaheadTransport(),
      valueKey: 'name',
      footer: $typeahead.data('footer'),
      template: suggestion
    });

    $typeahead.on('typeahead:selected', function(e, datum) {
      window.location.href = datum.url;
    });

    $typeahead.on('input', function(e) {
      if ($(window).width() < 600) {
        window.scrollTo(0, $typeahead.offset().top - 10);
      };
    })
  }
}

$(document).ready(search);
