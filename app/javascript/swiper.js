//app/javascript/swiper.js
document.addEventListener("turbo:load", function() {
  var swiper = new Swiper(".swiper-container", {
      direction: 'horizontal',
      loop: true,  // スライドをループさせるか
      slidesPerView: 1,
      spaceBetween: 30,
      pagination: {
          el: ".swiper-pagination",
          clickable: true,
      },
      navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
      },
      breakpoints: {
          799: {
              slidesPerView: 1,
              spaceBetween: 20,
          },
      }
  });
});
