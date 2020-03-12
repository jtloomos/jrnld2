import flatpickr from "flatpickr"
import "flatpickr/dist/themes/light.css" // Note this is important!

flatpickr(".datepicker", {
  altInput: true,
  allowInput: true,
  mode: "range",
  maxDate: "today",
})
