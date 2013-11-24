// Should clear label if current input does not match. Looks sluggsih when they overlap
// Arrow keys not working
// Shouldn't trigger search when releasing after a tab
// shouldn't trigger search when query is empty
// localStorage memoization

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
  return patt.test(string);
};

function substringJoin(input, string) {
  if (substringMatch(input, string)) {
    return input + string.substring(input.length);
  };
};

function renderLabel(value) {
  if (value == "") {
    $autocomplete_label.innerHTML = value;
  } else {
    $autocomplete_label.innerHTML = substringJoin($search.value, value);
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

function fetchRemote(query, callback) {
  xmlhttp = new XMLHttpRequest();

  xmlhttp.onreadystatechange = function() {
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
      callback();
    }
  }

  xmlhttp.open("GET", $search.dataset.remote + "?search=" + $search.value, true);
  xmlhttp.send();
}

$search.onkeydown = function(event) {
  var charCode = event.which || event.keyCode;
  console.log(charCode);

  if (charCode == 9) {
    if (list.length > 0) {
      event.preventDefault();
      renderLabel("");
      $search.value = list[0].value;
    };
  };
};

$search.onkeyup = function(event) {
  var charCode = event.which || event.keyCode;

  if (charCode == 40) {
    event.preventDefault();
    arrow(1);
  } else if (charCode == 38) {
    event.preventDefault();
    arrow(-1);
  } else if (searchHasChanged()) {
    fetchRemote($search.value, function() {
      renderList(xmlhttp.responseText);
    })
  };
};
