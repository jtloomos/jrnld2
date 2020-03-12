import mapboxgl from 'mapbox-gl';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 100, duration: 0 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 30, maxZoom: 5, duration: 0 });
  };

  const addMarkersToMap = (map, markers) => {
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this

      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '25px';
      element.style.height = '25px';

       new mapboxgl.Marker(element) // IF WE WANT A CUSTOM IMAGE, UNCOMMENT THE BLOCK ABOVE, THEN PASS "ELEMENT" AS AN ARGUMENT HERE.
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(map);
    });
  };

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/emiliedrop/ck7lzuq600ldd1isbt8c8ifww'
    });

    const markers = JSON.parse(mapElement.dataset.markers);
    fitMapToMarkers(map, markers);
    addMarkersToMap(map, markers);
  }

};

export { initMapbox };
