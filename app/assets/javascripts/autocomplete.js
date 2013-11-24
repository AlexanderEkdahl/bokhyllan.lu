$autocomplete       = document.getElementById('autocomplete');
$autocomplete_label = document.getElementById('autocomplete_label');
$search             = document.getElementById('search');
list                = []
current_item        = 0
previous_value      = $search.value

function searchHasChanged() {
  changed = previous_value != $search.value;

  if (changed) {
    previous_value = $search.value;
    return true;
  };

  return false;
}

function substringMatch(input, string) {
  var patt = new RegExp(input, 'i');
  if (patt.test(string)) {
    return input + string.substring(input.length);
  };
};

function renderLabel(value) {
  if (value == "") {
    $autocomplete_label.innerHTML = value;
  } else {
    $autocomplete_label.innerHTML = substringMatch($search.value, value);
  }
};

function renderList(result) {
  list = JSON.parse(result);

  $autocomplete.innerHTML = "";

  if (list.length > 0) {
    renderLabel(list[0].value);

    for (var i = 0; i < list.length; i++) {
      var element = document.createElement("a");
      element.setAttribute("href", list[i].url);
      element.innerHTML = list[i].value;
      $autocomplete.appendChild(element);
    }
  } else {
    renderLabel("");
  };
}

function arrow(direction) {
  if (list.length > 0) {
    current_item = (current_item + direction) % list.length;
  };
  console.log(current_item)
}

$search.onkeyup = function(event) {
  console.log(event);
  if (event.which == 40) {
    event.preventDefault();
    arrow(1);
  } else if (event.which == 38) {
    event.preventDefault();
    arrow(-1);
  } else if (searchHasChanged()) {
    xmlhttp = new XMLHttpRequest();

    xmlhttp.onreadystatechange = function() {
      if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        renderList(xmlhttp.responseText);
      }
    }

    xmlhttp.open("GET", $search.dataset.remote + "?search=" + $search.value, true);
    xmlhttp.send();
  };
};
