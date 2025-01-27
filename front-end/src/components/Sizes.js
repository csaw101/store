import "../styles/Sizes.css";

function Sizes(props) {
  return (
    <div className="product-sizes">
      <div className="product-label">SIZE:</div>
      <div className="size-list">
        {props.sizes.map((size) => (
          <div
            onClick={() => props.setSelectedSize(size.name)}
            className={
              size.name === props.selectedSize
                ? "size-box size-selected"
                : "size-box"
            }
            key={size.name}
          >
            {size.value}
          </div>
        ))}
      </div>
    </div>
  );
}

export default Sizes;
