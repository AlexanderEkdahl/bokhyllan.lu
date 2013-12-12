stathat = function(ukey, key) {
  var img = document.createElement("img")
  img.width = "1"
  img.height = "1"
  img.style = "display: none;"
  img.src = "http://api.stathat.com/c?ukey=" + ukey + "&key=" + key + "&count=1"
  document.body.appendChild(img)
}
