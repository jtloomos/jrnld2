document.querySelectorAll('.feedback li').forEach(emoji => emoji.addEventListener('click', e => {
  if(!emoji.classList.contains('active')) {
    document.querySelector('.feedback li.active').classList.remove('active');
    emoji.classList.add('active');

    const newValue = emoji.classList[0];
    const emojiField = document.querySelector("#emoji-value")
    emojiField.value = newValue
  }
  e.preventDefault();
}));

hidden_field = document.getElementById("entry_start_entry")
if (hidden_field) {
  document.addEventListener("keyup", (event) => {
    hidden_field.value = new Date()
  });
};
