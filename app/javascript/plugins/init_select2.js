import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2({
    tags: true,             // Allow custom tags to be entered
    tokenSeparators: [','], // Allow comma-separated tags
  });

  // Track all the reminder buttons
  const reminders = document.querySelectorAll('[id^=btn-reminder-]')

  if (reminders) {          // janette check this for a user without reminders!!
    reminders.forEach((reminder) => {
      reminder.addEventListener("click", (event) => {
        event.currentTarget.classList.toggle("active");
        // Upon reminder button click, do the following to add/remove entry tags:
        var data = JSON.parse(reminder.dataset.content);  // Hash of reminder attributes
        const values = $('.select2').val();   // Grab all the current entry tags
        // Check if reminder text exists in option list already
        const tagId = $('.select2 option').filter(function () { return $(this).html() == data.title; }).val()
        if (tagId) {
          if (event.currentTarget.classList.contains("active")) {
            values.push(tagId) // this needs to push to the end of the full list!!!
          } else { // remove the deactivated reminder from the entry tag list
            for( var i = 0; i < values.length; i++){ if ( values[i] === tagId) { values.splice(i, 1); i--; }}
          }
          $('.select2').val(values).trigger('change');
        } else {
          // Create a DOM Option and pre-select by default
          var newOption = new Option(data.title, "newTag"+data.id , true, true);
          // Append it to the select
          $('select.select2').append(newOption).trigger('change');
        }
      });
    });
  }






  // When EDIT an existing entry, pre-select existing entry tags, as follows:

  // Preselecting options in an remotely-sourced (AJAX) Select2
  // https://select2.org/programmatic-control/add-select-clear-items#preselecting-options-in-an-remotely-sourced-ajax-select2
  // OR...
  //$('.select2').val(['1', '2']); Array of pill IDs to pre.select, for the EDIT page
  //$('.select2').trigger('change'); // Notify any JS components that the value changed

};

export { initSelect2 };
