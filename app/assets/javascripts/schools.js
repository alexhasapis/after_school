
var map;

function initialize(data){
  
  var currentLocation = new google.maps.LatLng(data.latitude, data.longitude);

    var mapOptions = {
      center: currentLocation,
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };

  
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

    var marker = new google.maps.Marker();
marker.setPosition(currentLocation);
marker.setMap(map);
};

$(document).ready(function(){
    // var latitude = parseFloat($('p#lat').text())
    // var longitude = parseFloat($('p#long').text())

    // initialize(latitude, longitude);

});