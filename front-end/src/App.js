import { useState } from "react";

import Products from "./components/Products";
import Navbar from "./components/Navbar";
import Cart from "./components/Cart";
import Product from "./components/Product";
import Categories from "./components/Categories";

import * as Enums from "./Enums";

import "./styles/App.css";

function App() {
  const [categoryID, setCategoryID] = useState(Enums.Category.ALL);
  const [mainView, setMainView] = useState(Enums.View.PRODUCTS);

  const [productView, setProductView] = useState();

  const [cartOverlay, setCartOverlay] = useState(false);

  const [cartState, setCartState] = useState([]);
  const addToCart = (newProduct) => {
    for (var i = 0; i < cartState.length; i++) {
      if (
        cartState[i].id === newProduct.id &&
        cartState[i].color === newProduct.color &&
        cartState[i].size === newProduct.size &&
        cartState[i].capacity === newProduct.capacity &&
        cartState[i].usb3 === newProduct.usb3 &&
        cartState[i].touchID === newProduct.touchID
      ) {
        incrementCartItemAmount(
          newProduct.id,
          newProduct.color,
          newProduct.size,
          newProduct.capacity,
          newProduct.usb3,
          newProduct.touchID,
        );
        return;
      }
    }
    setCartState([...cartState, newProduct]);
  };

  const incrementCartItemAmount = (
    id,
    color,
    size,
    capacity,
    usb3,
    touchID,
  ) => {
    setCartState(
      cartState.map((cartProduct) =>
        cartProduct.id === id &&
        cartProduct.color === color &&
        cartProduct.size === size &&
        cartProduct.capacity === capacity &&
        cartProduct.usb3 === usb3 &&
        cartProduct.touchID === touchID
          ? {
              ...cartProduct,
              amount: cartProduct.amount + 1,
            }
          : cartProduct,
      ),
    );
  };

  const decrementCartItemAmount = (
    id,
    color,
    size,
    capacity,
    usb3,
    touchID,
  ) => {
    setCartState((cartState) =>
      cartState.reduce((updatedCart, cartProduct) => {
        if (
          cartProduct.id === id &&
          cartProduct.color === color &&
          cartProduct.size === size &&
          cartProduct.capacity === capacity &&
          cartProduct.usb3 === usb3 &&
          cartProduct.touchID === touchID
        ) {
          if (cartProduct.amount > 1) {
            updatedCart.push({
              ...cartProduct,
              amount: cartProduct.amount - 1,
            });
          }
        } else {
          updatedCart.push(cartProduct);
        }
        return updatedCart;
      }, []),
    );
  };

  const getSumOfCartProducts = () =>
    cartState.reduce((total, product) => (total += product.amount), 0);
  return (
    <div className="App">
      <Navbar
        cartNumberOfItems={getSumOfCartProducts()}
        setCategoryID={setCategoryID}
        setMainView={setMainView}
        setCartOverlay={setCartOverlay}
      />
      {mainView === Enums.View.PRODUCTS ? (
        <Products
          addToCart={addToCart}
          categoryID={categoryID}
          setMainView={setMainView}
          setProductView={setProductView}
        />
      ) : (
        <Product id={productView} addToCart={addToCart} />
      )}
      <Categories
        className="categories-list categories-mobile"
        setCategoryID={setCategoryID}
        setMainView={setMainView}
      />
      {cartOverlay ? (
        <div>
          <Cart
            setCartOverlay={setCartOverlay}
            cartState={cartState}
            incrementCartItemAmount={incrementCartItemAmount}
            decrementCartItemAmount={decrementCartItemAmount}
          />
          <div className="cart-overlay"></div>
        </div>
      ) : null}
    </div>
  );
}

export default App;
