const plus = document.querySelector("#plus-reminder")
const repo = document.querySelector(".default-reminders")

const HTML = (title) => {return `<input id="reminder-check-${title}" class ="reminder-check" name="reminder-${title}" type="checkbox" value=${title.toUpperCase()} checked><div class="btn-ghost reminder active"><label for="reminder-${title}" class="reminder-label">${title.toUpperCase()}</label></div>`}

plus.addEventListener("click", (event) => {
  const title = document.querySelector("#new-reminder")
  if (title.value !== "") {
  repo.insertAdjacentHTML("beforeend", HTML(title.value))
  };
  title.value = ""
})



