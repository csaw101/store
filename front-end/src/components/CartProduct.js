import "../styles/CartProduct.css";

function CartProduct(props) {
  return (
    <div className="cart-product">
      <div className="cart-product-details">
        <div className="cart-product-label">{props.cartProduct.name}</div>
        <div className="cart-product-price bold">
          {props.cartProduct.currency}
          {props.cartProduct.price}
        </div>
        {props.cartProduct.sizes.length > 0 ? (
          <div className="cart-product-sizes">
            <div className="cart-product-label">SIZE:</div>
            <div className="cart-size-list">
              {props.cartProduct.sizes.map((size) => (
                <div
                  className={
                    size.name === props.cartProduct.size
                      ? "cart-size-box cart-size-selected"
                      : "cart-size-box"
                  }
                  key={size.name}
                >
                  {size.value}
                </div>
              ))}
            </div>
          </div>
        ) : null}
        {props.cartProduct.colors.length > 0 ? (
          <div className="cart-product-colors">
            <div className="cart-product-label">COLOR:</div>
            <div className="cart-color-list">
              {props.cartProduct.colors.map((color) => (
                <div
                  className={
                    color.name === props.cartProduct.color
                      ? "cart-color-box cart-color-selected"
                      : "cart-color-box"
                  }
                  style={{
                    backgroundColor: "#" + color.value,
                    border:
                      color.value === "FFFFFF" ? "solid 1px #28231D" : null,
                  }}
                  key={color.name}
                ></div>
              ))}
            </div>
          </div>
        ) : null}
        {props.cartProduct.capacities.length > 0 ? (
          <div className="cart-product-sizes">
            <div className="cart-product-label">CAPACITY:</div>
            <div className="cart-size-list">
              {props.cartProduct.capacities.map((capacity) => (
                <div
                  className={
                    capacity.name === props.cartProduct.capacity
                      ? "cart-size-box cart-size-selected"
                      : "cart-size-box"
                  }
                  key={capacity.name}
                >
                  {capacity.value}
                </div>
              ))}
            </div>
          </div>
        ) : null}
        <div className="cart-product-usb3-touchID">
          {props.cartProduct.usb3 !== undefined ? (
            <div className="cart-product-usb3">
              {props.cartProduct.usb3 === true ? (
                <img src="https://scandi-test.com/assets/usb3.png" alt="" />
              ) : null}
            </div>
          ) : null}
          {props.cartProduct.touchID !== undefined ? (
            <div className="cart-product-touchID">
              {props.cartProduct.touchID === true ? (
                <img src="https://scandi-test.com/assets/touchID.png" alt="" />
              ) : null}
            </div>
          ) : null}
        </div>
      </div>
      <div className="cart-product-quantity">
        <div
          className="cart-product-increment"
          onClick={() => {
            props.incrementCartItemAmount(
              props.cartProduct.id,
              props.cartProduct.color,
              props.cartProduct.size,
              props.cartProduct.capacity,
              props.cartProduct.usb3,
              props.cartProduct.touchID,
            );
          }}
        >
          +
        </div>
        <div className="cart-product-amount">{props.cartProduct.amount}</div>
        <div
          className="cart-product-decrement"
          onClick={() => {
            props.decrementCartItemAmount(
              props.cartProduct.id,
              props.cartProduct.color,
              props.cartProduct.size,
              props.cartProduct.capacity,
              props.cartProduct.usb3,
              props.cartProduct.touchID,
            );
          }}
        >
          -
        </div>
      </div>
      <div className="cart-product-img">
        <img src={props.cartProduct.image} alt="" />
      </div>
    </div>
  );
}

export default CartProduct;
