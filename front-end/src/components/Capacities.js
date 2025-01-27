import "../styles/Capacities.css";

function Capacities(props) {
  return (
    <div className="product-sizes">
      <div className="product-label">CAPACITY:</div>
      <div className="size-list">
        {props.capacities.map((capacity) => (
          <div
            onClick={() => props.setSelectedCapacity(capacity.name)}
            className={
              capacity.name === props.selectedCapacity
                ? "size-box size-selected"
                : "size-box"
            }
            key={capacity.name}
          >
            {capacity.value}
          </div>
        ))}
      </div>
    </div>
  );
}

export default Capacities;
