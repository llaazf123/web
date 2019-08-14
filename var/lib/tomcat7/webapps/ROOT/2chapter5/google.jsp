<!DOCTYPE html>
<html>
  <head>
    <style>
      /* Set the size of the div element that contains the map */
      #map {
        height: 400px;  /* The height is 400 pixels */
        width: 100%;  /* The width is the width of the web page */
       }
    </style>
  </head>
  <body>
  <%
  String coordx = request.getParameter("coordx");
  String coordy = request.getParameter("coordy");
  
  %>
    <h3>My Google Maps Demo</h3>
    <!--The div element for the map -->
    <div id="map"></div>
    <script>
// Initialize and add the map
function initMap() {
	var coordx = <%=coordx%>
	var coordy = <%=coordy%>
  // The location of Uluru
  var uluru = {lat: coordy, lng: coordx};
  // The map, centered at Uluru
  var map = new google.maps.Map(
      document.getElementById('map'), {zoom: 10, center: uluru});
  // The marker, positioned at Uluru
  var marker = new google.maps.Marker({position: uluru, map: map});
}
    </script>

	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB15lkG0GjxlP9ykjBZ0j43xogqHTos5vc&callback=initMap">
    </script>
  </body>
</html>