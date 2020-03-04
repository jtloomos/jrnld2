const reminders = document.querySelectorAll('#btn-reminder')

reminders.forEach((reminder) => {
  reminder.addEventListener("click", (event) => {
    event.currentTarget.classList.toggle("active");
  });
});
