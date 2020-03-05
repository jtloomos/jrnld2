import "bootstrap";
import "../entries/new"
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import { initMapbox } from '../plugins/init_mapbox';
import { initSelect2 } from '../plugins/init_select2';
import 'select2/dist/css/select2.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!


initMapbox();
initSelect2();
