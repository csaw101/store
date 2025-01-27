import { useQuery, useLazyQuery, gql } from "@apollo/client";

import * as Enums from "../Enums";

import "../styles/Products.css";

const GET_PRODUCTS = gql`
  query GetProducts($id: Int, $page: Int, $products_per_page: Int) {
    products(id: $id, page: $page, products_per_page: $products_per_page) {
      id
      name
      image
      in_stock
      price
      currency
    }
  }
`;

const GET_ATTRIBUTES = gql`
  query GetAttributes($id: Int) {
    attributes(id: $id) {
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

function Products(props) {
  const { loading, error, data } = useQuery(GET_PRODUCTS, {
    variables: { id: props.categoryID, page: 1, products_per_page: 8 },
  });

  const [getAttributes, { attrLoading, attrError, attrData }] =
    useLazyQuery(GET_ATTRIBUTES);
  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: ${error}</p>;

  if (attrLoading) return <p>Loading...</p>;
  if (attrError) return <p>Error: ${attrError}</p>;

  const handleQuery = async (product, addToCart) => {
    var attributesPromise = await getAttributes({
      variables: { id: product.id },
    });
    var colors = attributesPromise.data.attributes.colors;
    var sizes = attributesPromise.data.attributes.sizes;
    var capacities = attributesPromise.data.attributes.capacities;
    var usb3 = attributesPromise.data.attributes.usb3;
    var touchID = attributesPromise.data.attributes.touchID;

    props.addToCart({
      id: product.id,
      name: product.name,
      image: product.image,
      price: product.price,
      currency: product.currency,
      amount: 1,
      colors: colors.length > 0 ? colors : [],
      color: colors.length > 0 ? colors[0].name : undefined,
      sizes: sizes.length > 0 ? sizes : [],
      size: sizes.length > 0 ? sizes[0].name : undefined,
      capacities: capacities.length > 0 ? capacities : [],
      capacity: capacities.length > 0 ? capacities[0].name : undefined,
      usb3: usb3 === true ? false : undefined,
      touchID: touchID === true ? false : undefined,
    });
  };

  return (
    <div className="grid">
      {data.products.map((product) => (
        <div key={product.id} className="product-card">
          <div
            className="product-img"
            onClick={() => {
              props.setProductView(product.id);
              props.setMainView(Enums.View.PRODUCT);
            }}
          >
            <img src={product.image} alt="" />
            {product.in_stock === true ? null : (
              <div className="overlay">OUT OF STOCK</div>
            )}
          </div>
          {product.in_stock === true ? (
            <div
              className="product-cart"
              onClick={() => handleQuery(product, props.addToCart)}
            >
              <img
                src="https://scandi-test.com/assets/cart-180x180-green.png"
                alt="Cart"
              />
            </div>
          ) : null}
          <div
            className="product-text"
            onClick={() => {
              props.setProductView(product.id);
              props.setMainView(Enums.View.PRODUCT);
            }}
          >
            <h2 className="products-name">{product.name}</h2>
            <p className="products-price">
              {product.currency}
              {product.price}
            </p>
          </div>
        </div>
      ))}
    </div>
  );
}

export default Products;
