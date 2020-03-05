const reminders = document.querySelectorAll('[id^=btn-reminder-]')
// const entryTagsDiv = document.querySelector('#entry-tags-div')
// TO BE USED TO ADD PILLS TO THE TAGS INPUT

if (reminders) { //janette - check this for a user without reminders!!
  reminders.forEach((reminder) => {
    reminder.addEventListener("click", (event) => {
      event.currentTarget.classList.toggle("active");
      // SET A SELECT2 FUNCTION TO CREATE A NEW OPTION AND THEN SELECT THIS NEW OPTION
      // USING THE TEXT OF THE CLICKED REMINDER AND ID BTN-REMINDER-<ID>
    });
  });
}
