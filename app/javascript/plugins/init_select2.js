import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2({
    tags: true,
    tokenSeparators: [',',],
  }); // (~ document.querySelectorAll)
};

export { initSelect2 };


// When clicking a reminder button, do the following (how to toggle OFF though?):

// Creating new options in the dropdown
var data = {
    id: "btn-reminder-8",
    text: 'school'
};

// Create if not exists
// Set the value, creating a new option if necessary
if ($('#mySelect2').find("option[value='" + data.id + "']").length) {
    $('#mySelect2').val(data.id).trigger('change');
} else {
    // Create a DOM Option and pre-select by default
    var newOption = new Option(data.text, data.id, true, true);
    // Append it to the select
    $('#mySelect2').append(newOption).trigger('change');
}



// When EDIT an existing entry, pre-select existing entry tags, as follows:

// Preselecting options in an remotely-sourced (AJAX) Select2
// https://select2.org/programmatic-control/add-select-clear-items#preselecting-options-in-an-remotely-sourced-ajax-select2
// OR...
//$('.select2').val(['1', '2']); Array of pill IDs to pre.select, for the EDIT page
//$('.select2').trigger('change'); // Notify any JS components that the value changed
