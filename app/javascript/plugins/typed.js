import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  if (document.getElementById("banner-typed-text")) {
    new Typed('#banner-typed-text', {
      strings: ["A journal made for the modern world"],
      typeSpeed: 100,
      loop: false
    });
  }
}

export { loadDynamicBannerText };
