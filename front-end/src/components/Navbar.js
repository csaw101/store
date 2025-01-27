import Categories from "../components/Categories";
import * as Enums from "../Enums";
import "../styles/Navbar.css";

function Navbar(props) {
  return (
    <div className="navbar">
      <Categories
        className="navbar-left categories-list"
        setCategoryID={props.setCategoryID}
        setMainView={props.setMainView}
      />
      <div className="navbar-center">
        <div
          className="navbar-logo"
          onClick={() => {
            props.setMainView(Enums.View.PRODUCTS);
          }}
        >
          <img
            src="https://img.stackshare.io/service/9528/FB_Profile.png"
            alt="Store Logo"
          />
        </div>
      </div>
      <div className="navbar-right">
        <div className="navbar-cart" onClick={() => props.setCartOverlay(true)}>
          <img
            src="https://scandi-test.com/assets/cart-180x180-black.png"
            alt="Cart"
          />
          {props.cartNumberOfItems > 0 ? (
            <div className="cart-bubble">
              <p>{props.cartNumberOfItems}</p>
            </div>
          ) : null}
        </div>
      </div>
    </div>
  );
}

export default Navbar;
