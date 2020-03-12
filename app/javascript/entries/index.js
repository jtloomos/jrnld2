function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

window.onload =  function() {
  const cards = document.querySelectorAll(".holder")

  if (cards) {
    cards.forEach((card) => {
      card.addEventListener("pointerenter", async (event) => {
        const emoji = card.querySelector(".emoji-target");
        emoji.classList.remove("active");
        await sleep(10);
        emoji.classList.add("active");
      });
    })
  };
};

const input = document.getElementById("search_query")
const form = document.getElementById("filtering-index-form")

if (input && form) {
  input.addEventListener("keyup", (event) => {
    if (event.key === "Enter") {
      form.submit()
    }
  })
}
