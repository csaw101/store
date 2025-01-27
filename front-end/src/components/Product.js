import { gql, useQuery } from "@apollo/client";
import { useState, useEffect } from "react";

import Carousel from "./Carousel";
import Colors from "./Colors";
import Sizes from "./Sizes";
import Capacities from "./Capacities";
import DOMPurify from "dompurify";
import parse from "html-react-parser";

import "../styles/Product.css";
import "../styles/switch.css";

const GET_PRODUCT = gql`
  query GetProduct($id: Int) {
    product(id: $id) {
      name
      description
      price
      currency
      images
      in_stock
      colors {
        name
        value
      }
      sizes {
        name
        value
      }
      capacities {
        name
        value
      }
      usb3
      touchID
    }
  }
`;

function Product(props) {
  const [selectedColor, setSelectedColor] = useState(undefined);
  const [selectedSize, setSelectedSize] = useState(undefined);
  const [selectedCapacity, setSelectedCapacity] = useState(undefined);
  const [selectedUsb3, setSelectedUsb3] = useState(undefined);
  const [selectedTouchID, setSelectedTouchID] = useState(undefined);

  const { loading, error, data } = useQuery(GET_PRODUCT, {
    variables: { id: props.id },
  });

  useEffect(
    (product) => {
      if (loading !== true && data !== undefined) {
        if (data.product.colors.length > 0) {
          setSelectedColor(data.product.colors[0].name);
        }
        if (data.product.sizes.length > 0) {
          setSelectedSize(data.product.sizes[0].name);
        }
        if (data.product.capacities.length > 0) {
          setSelectedCapacity(data.product.capacities[0].name);
        }
        if (data.product.usb3 === true) {
          setSelectedUsb3(false);
        }
        if (data.product.touchID === true) {
          setSelectedTouchID(false);
        }
      }
    },
    [loading, data],
  );
  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error.message}</p>;

  function parseDescription(description) {
    const sanitizedHTML = DOMPurify.sanitize(description);
    return parse(sanitizedHTML);
  }

  return (
    <div className="product">
      <Carousel images={data.product.images} />
      <div className="product-details">
        <div className="product-name">{data.product.name}</div>
        {data.product.sizes.length > 0 ? (
          <Sizes
            sizes={data.product.sizes}
            selectedSize={selectedSize}
            setSelectedSize={setSelectedSize}
          />
        ) : null}
        {data.product.colors.length > 0 ? (
          <Colors
            colors={data.product.colors}
            selectedColor={selectedColor}
            setSelectedColor={setSelectedColor}
          />
        ) : null}
        {data.product.capacities.length > 0 ? (
          <Capacities
            capacities={data.product.capacities}
            selectedCapacity={selectedCapacity}
            setSelectedCapacity={setSelectedCapacity}
          />
        ) : null}
        {data.product.usb3 === true && selectedUsb3 !== undefined ? (
          <div className="product-usb3">
            <div className="product-label">With USB3 Ports:</div>
            <div
              className="usb3-availability"
              onClick={(e) => {
                e.preventDefault();
                document.getElementById("usb3-button").checked = !selectedUsb3;
                setSelectedUsb3(!selectedUsb3);
              }}
            >
              <img src="https://scandi-test.com/assets/usb3.png" alt="" />
              <label className="switch">
                <input id="usb3-button" type="checkbox" />
                <span className="slider round"></span>
              </label>
            </div>
          </div>
        ) : null}
        {data.product.touchID === true && selectedTouchID !== undefined ? (
          <div className="product-touchID">
            <div className="product-label">Touch ID in Keyboard:</div>
            <div
              className="touchID-availability"
              onClick={(e) => {
                e.preventDefault();
                document.getElementById("touchID-button").checked =
                  !selectedTouchID;
                setSelectedTouchID(!selectedTouchID);
              }}
            >
              <img src="https://scandi-test.com/assets/touchID.png" alt="" />
              <label className="switch">
                <input id="touchID-button" type="checkbox" />
                <span className="slider round"></span>
              </label>
            </div>
          </div>
        ) : null}
        <div className="product-price">
          <div className="product-label">PRICE:</div>
          <div className="price-amount">
            {data.product.currency}
            {data.product.price}
          </div>
        </div>
        <div
          className="product-button"
          style={
            data.product.in_stock === false
              ? {
                  backgroundColor: "#9e9e9e",
                }
              : null
          }
          onClick={
            data.product.in_stock === true
              ? () => {
                  props.addToCart({
                    id: props.id,
                    amount: 1,
                    name: data.product.name,
                    image: data.product.images[0],
                    price: data.product.price,
                    currency: data.product.currency,
                    colors: data.product.colors,
                    color: selectedColor,
                    sizes: data.product.sizes,
                    size: selectedSize,
                    capacities: data.product.capacities,
                    capacity: selectedCapacity,
                    usb3: selectedUsb3,
                    touchID: selectedTouchID,
                  });
                }
              : null
          }
        >
          {data.product.in_stock ? "ADD TO CART" : "OUT OF STOCK"}
        </div>
        <div className="product-description">
          {parseDescription(data.product.description)}
        </div>
      </div>
    </div>
  );
}

export default Product;
