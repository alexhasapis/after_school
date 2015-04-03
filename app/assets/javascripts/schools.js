
var map;
// create map
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

// find afterschool programs in the area
function findAfterSchoolProgs(latitude, longitude){
  $.ajax({
      url:      '/getschoolprogs',
      type:     'POST',
      dataType: 'json',
      data:     {lat: latitude, long: longitude}
  }).done(function(data) {
    console.log(data)
    for (var i = 0; i < data.length; i++){
      var point = new google.maps.LatLng(data[i].latitude, data[i].longitude);

      var marker = new google.maps.Marker({
          position: point,
          map: map,
          icon: '/assets/daycare.png',
          title: data[i].program,
          clickable: true
        })

      marker.info = new google.maps.InfoWindow({
      content: '<b>Type:</b> ' 
      + data[i].program_type +'<br> <b>Site:</b>' + data[i].program_site + '<br> <b>Partner:</b>' + data[i].agency 
      });

      google.maps.event.addListener(marker, 'click', (function(marker) {
            return function() {
                this.info.open(map, marker);
            }
        })(marker));
    }
  });
}



$(document).ready(function(){
    // var latitude = parseFloat($('p#lat').text())
    // var longitude = parseFloat($('p#long').text())

    // initialize(latitude, longitude);

});