const reminders = document.querySelectorAll('.reminder-label')
// const entryTagsDiv = document.querySelector('#entry-tags-div')
// TO BE USED TO ADD PILLS TO THE TAGS INPUT

reminders.forEach((reminder) => {
  reminder.addEventListener("click", (event) => {
    event.currentTarget.parentElement.classList.toggle("active");
  });
});
