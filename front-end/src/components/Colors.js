import "../styles/Colors.css";

function Colors(props) {
  return (
    <div className="product-colors">
      <div className="product-label">COLOR:</div>
      <div className="color-list">
        {props.colors.map((color) => (
          <div
            onClick={() => props.setSelectedColor(color.name)}
            className={
              color.name === props.selectedColor
                ? "color-box color-selected"
                : "color-box"
            }
            style={{
              backgroundColor: "#" + color.value,
              border: color.value === "FFFFFF" ? "solid 1px #28231D" : null,
            }}
            key={color.name}
          ></div>
        ))}
      </div>
    </div>
  );
}

export default Colors;
