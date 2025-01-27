document.addEventListener("scroll", function () {
  const target = document.querySelector(".product-card");
  const rect = target.getBoundingClientRect();

  const isInViewport =
    rect.top >= 0 &&
    rect.left >= 0 &&
    rect.bottom <=
      (window.innerHeight || document.documentElement.clientHeight) &&
    rect.right <= (window.innerWidth || document.documentElement.clientWidth);

  if (isInViewport) {
    target.style.backgroundColor = "lightgreen";
  } else {
    target.style.backgroundColor = "lightblue";
  }
});
