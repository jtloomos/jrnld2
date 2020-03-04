const reminders = document.querySelectorAll('#btn-reminder')
const entryTagsDiv = document.querySelector('#entry-tags-div')

reminders.forEach((reminder) => {
  reminder.addEventListener("click", (event) => {
    event.currentTarget.classList.toggle("active");
  });
});
