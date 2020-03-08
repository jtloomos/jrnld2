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

