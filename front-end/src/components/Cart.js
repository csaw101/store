import { gql, useMutation } from "@apollo/client";
import CartProduct from "./CartProduct";
import "../styles/Cart.css";

const ORDERS_MUTATION = gql`
  mutation CreateOrder($order: [OrderedProduct]!) {
    createOrder(order: $order) {
      id
    }
  }
`;

function sumTotal(products) {
  return products.reduce(
    (total, product) => (total += product.amount * product.price),
    0,
  );
}

function getAmount(products) {
  return products.reduce((total, product) => (total += product.amount), 0);
}

function Cart(props) {
  const [createOrder] = useMutation(ORDERS_MUTATION);

  return (
    <div className="cart-modal">
      <div className="modal-content">
        <div className="cart-header">
          <div>
            <span className="bold">My Bag: </span>
            <span>{getAmount(props.cartState)} items</span>
          </div>
          <div className="cart-close">
            <img
              onClick={() => props.setCartOverlay(false)}
              src="https://scandi-test.com/assets/cart-close.png"
              alt=""
            />
          </div>
        </div>
        {props.cartState.map((cartProduct) => (
          <CartProduct
            cartProduct={cartProduct}
            incrementCartItemAmount={props.incrementCartItemAmount}
            decrementCartItemAmount={props.decrementCartItemAmount}
            key={
              cartProduct.id.toString() +
              cartProduct.color +
              cartProduct.size +
              cartProduct.capacity +
              cartProduct.usb3 +
              cartProduct.touchID
            }
          />
        ))}
        <div className="cart-total">
          <span>Total</span>
          <span>${sumTotal(props.cartState).toFixed(2)}</span>
        </div>
        <div
          className="cart-order-btn"
          style={
            props.cartState.length === 0
              ? {
                  backgroundColor: "#9e9e9e",
                }
              : null
          }
          onClick={
            props.cartState.length > 0
              ? () => {
                  const orderedProducts = props.cartState.map(
                    ({
                      name,
                      image,
                      currency,
                      price,
                      colors,
                      sizes,
                      capacities,
                      ...keepAttrs
                    }) => keepAttrs,
                  );
                  createOrder({
                    variables: {
                      order: orderedProducts,
                    },
                  });
                }
              : null
          }
        >
          PLACE ORDER
        </div>
      </div>
    </div>
  );
}
export default Cart;
