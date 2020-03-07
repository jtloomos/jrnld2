const plus = document.querySelector("#plus-reminder")
const repo = document.querySelector(".default-reminders")
const title = document.querySelector("#new-reminder")

const HTML = (title) => {return `<input id="reminder-check-${title}" class ="reminder-check" name="reminder-${title}" type="checkbox" value=${title.toUpperCase()} checked><div class="btn-ghost reminder"><label for="reminder-check-${title}" class="reminder-label">${title.toUpperCase()}</label></div>`}

const addHTML = (title) => {
  repo.insertAdjacentHTML("beforeend", HTML(title.value))
  title.value = ""
}

if (plus) {
  plus.addEventListener("click", (event) => {
    if (title.value !== "") {
      addHTML(title);
    };
  })
}

if (title) {
  title.addEventListener("keypress", (event) => {
    if (event.key === "Enter") {
      event.preventDefault();
      addHTML(title);
    }
  });
};
