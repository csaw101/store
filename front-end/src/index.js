import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import {
  ApolloProvider,
  ApolloClient,
  InMemoryCache,
  gql,
} from "@apollo/client";
import "./index.css";

const client = new ApolloClient({
  uri: "https://scandi-test.com",
  cache: new InMemoryCache(),
  // connectToDevTools: true,
});

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  // <React.StrictMode>
  <ApolloProvider client={client}>
    <App />
  </ApolloProvider>,
  // </React.StrictMode>,
);

// client
//   .query({
//     query: gql`
//       query Products {
//         products {
//           id
//           name
//           description
//           price
//         }
//       }
//     `,
//   })
//   .then((result) => console.log(result));
