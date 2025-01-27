import { useState } from "react";
import Swiper from "swiper";
import { Navigation } from "swiper/modules";

import "../styles/Carousel.css";
import "swiper/css";
import "swiper/css/navigation";

function Carousel(props) {
  const swiper = new Swiper(".swiper", {
    modules: [Navigation],
    direction: "horizontal",
    loop: true,
    slidesPerView: "auto",
    centeredSlides: true,
    spaceBetween: 15,
    slidesPerGroup: 1,
    loopFillGroupWithBlank: false,
    loopAdditionalSlides: 2,
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
  });
  const [carouselImage, setCarouselImage] = useState(props.images[0]);

  return (
    <div className="product-carousel">
      <div className="carousel-sidebar">
        {props.images.map((imageURL, index) => (
          <img
            key={index}
            src={imageURL}
            alt=""
            // onClick={() => setCarouselImage(imageURL)}
          />
        ))}
      </div>
      <div className={"swiper carousel-swipe"}>
        <div className="swiper-wrapper">
          {/* <img src={carouselImage} alt="" /> */}
          {props.images.map((imageURL, index) => (
            <div key={index} className="swiper-slide">
              <img
                src={imageURL}
                alt=""
                // onClick={() => setCarouselImage(imageURL)}
              />
            </div>
          ))}
        </div>
        <div class="swiper-button-prev" style={{ color: "#6cc682" }}></div>
        <div class="swiper-button-next" style={{ color: "#6cc682" }}></div>
      </div>
      <div className="carousel-bottombar">
        {props.images.map((imageURL, index) => (
          <img
            key={index}
            src={imageURL}
            alt=""
            // onClick={() => setCarouselImage(imageURL)}
          />
        ))}
      </div>
    </div>
  );
}

export default Carousel;
