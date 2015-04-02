
var map;

function initialize(data){
  
  var currentLocation = new google.maps.LatLng(data.latitude, data.longitude);

  var mapOptions = {
    center: currentLocation,
    zoom: 14,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  var marker = new google.maps.Marker({
    icon: '/assets/highschool.png'
  });
  marker.setPosition(currentLocation);
  marker.setMap(map);

  findAfterSchoolProgs(data.latitude, data.longitude)
};

function findAfterSchoolProgs(latitude, longitude){
  $.ajax({
      url:      '/getschoolprogs',
      type:     'POST',
      dataType: 'json',
      data:     {lat: latitude, long: longitude}
  }).done(function(data) {
    console.log(data)
    for (var i = 0; i < data.length; i++){
      var marker = new google.maps.Marker({
          position: new google.maps.LatLng(data[i].latitude, data[i].longitude),
          map: map,
          icon: '/assets/daycare.png'
        })
    }
  });
}



$(document).ready(function(){
    // var latitude = parseFloat($('p#lat').text())
    // var longitude = parseFloat($('p#long').text())

    // initialize(latitude, longitude);

});