import { useQuery, gql } from "@apollo/client";

import * as Enums from "../Enums";

import "../styles/Categories.css";

const GET_CATEGORIES = gql`
  query GetCategories {
    categories {
      id
      name
    }
  }
`;

function Categories(props) {
  const { loading, error, data } = useQuery(GET_CATEGORIES);

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error :(</p>;

  const handleCategorySelection = (categoryID, setCategoryID, setMainView, categoryName) => {
    setCategoryID(categoryID);
    setMainView(Enums.View.PRODUCTS);

    var old_selection;
    do {
      old_selection = document.getElementsByClassName("selected-category");
      old_selection[0].classList.remove("selected-category");
    } while (old_selection[0]);

    var new_selection = document.getElementsByClassName(
      "category-" + categoryName,
    );
    for (const element of new_selection) {
      element.classList.add("selected-category");
    }
  };

  const getClasses = (categoryName) => {
    if (categoryName === "all") {
      return "category-" + categoryName + " selected-category";
    }
    return "category-" + categoryName;
  };

  return (
    <div className={props.className}>
      <ul>
        {data.categories.map((category) => (
          <li
            key={category.name}
            className={getClasses(category.name)}
            onClick={() =>
              handleCategorySelection(
                category.id,
                props.setCategoryID,
                props.setMainView,
                category.name,
              )
            }
          >
            {category.name.toUpperCase()}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default Categories;
