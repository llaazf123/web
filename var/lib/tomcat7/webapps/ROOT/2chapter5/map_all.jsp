<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*,java.util.*"%>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*"%>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Marker Clustering</title>
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
  </head>
  <body>
  <% 
  	String strUrl = "http://openapi.its.go.kr:8082/api/NEventIdentity?key=1498271446332&ReqType=2&MinX=127.100000&MaxX=128.890000&MinY=34.100000%20&MaxY=39.100000&type=its";
	
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document doc = builder.parse(strUrl);
	NodeList tag_eventtype = doc.getElementsByTagName("eventtype");

	String coordxArr =  request.getParameter("coordxArr");
	String coordyArr =  request.getParameter("coordyArr");  
	
	String[] coordxArr_split = coordxArr.split(",");
	String[] coordyArr_split = coordyArr.split(",");

  %>
    <div id="map"></div>
    <script>
	
      function initMap() {
		
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 8,
          center: {lat: 35.9862309, lng: 128.4187183 }
        });

        // Create an array of alphabetical characters used to label the markers.
        var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

        // Add some markers to the map.
        // Note: The code uses the JavaScript Array.prototype.map() method to
        // create an array of markers based on a given "locations" array.
        // The map() method here has nothing to do with the Google Maps API.
        var markers = locations.map(function(location, i) {
          return new google.maps.Marker({
            position: location,
            label: labels[i % labels.length]
          });
        });

        // Add a marker clusterer to manage the markers.
        var markerCluster = new MarkerClusterer(map, markers,
            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
      }
      var locations = [
		  <%for(int i=0;i<tag_eventtype.getLength();i++){%>	
			{lat: <%=coordyArr_split[i]%>, lng: <%=coordxArr_split[i]%>},
		<%}%>
      ]
    </script>
    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB15lkG0GjxlP9ykjBZ0j43xogqHTos5vc&callback=initMap">
    </script>
  </body>
</html>