import "bootstrap";
import "../entries/new";
import "../entries/index";
import "../preferences/add";
import { loadDynamicBannerText } from '../plugins/typed';
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import { initMapbox } from '../plugins/init_mapbox';
import { initSelect2 } from '../plugins/init_select2';

import { initAutocomplete } from "../plugins/init_autocomplete"
import "../plugins/flatpickr"

import 'select2/dist/css/select2.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import $ from 'jquery';

loadDynamicBannerText();
initMapbox();
initAutocomplete()
initSelect2();
