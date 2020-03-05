import places from 'places.js';

const initAutocomplete = () => {
  if (document.querySelector(".auto-address")) {
    const addressInput = document.querySelector('.auto-address');
    if (addressInput) {
      places({ container: addressInput });
    }
  }
};

export { initAutocomplete };
