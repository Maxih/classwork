import React from "react";
import ReactDOM from "react-dom";

import Tabs from "./tabs.jsx";
import Clock from "./clock.jsx";
import Weather from "./weather.jsx";
import AutoComplete from "./autocomplete.jsx";

class Root extends React.Component {
  render () {
    const tabData = [
      {title: "hi",content: "world"},
      {title: "hola", content: "mundo"},
      {title: "This", content: "is the best tab ever"}
    ];

    const Names = [
      'Abba',
      'Barney',
      'Barbara',
      'Jeff',
      'Jenny',
      'Sarah',
      'Sally',
      'Xander'
    ];
    return (
      <figure>
        <Tabs panes={tabData}/>
        <Clock/>
        <Weather/>
        <AutoComplete names={Names}/>
      </figure>
    );
  }
}


document.addEventListener("DOMContentLoaded", () => {
  const main = document.querySelector("div#main");

  ReactDOM.render(<Root/>, main);
});
