const reminders = document.querySelectorAll('#btn-reminder')
// const entryTagsDiv = document.querySelector('#entry-tags-div')
// TO BE USED TO ADD PILLS TO THE TAGS INPUT

reminders.forEach((reminder) => {
  reminder.addEventListener("click", (event) => {
    event.currentTarget.classList.toggle("active");
  });
});
