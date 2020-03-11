function sleep(ms) {
  console.log("bubu")
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
