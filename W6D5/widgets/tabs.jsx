import React from "react";

export default class Tabs extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      selectedPane: 0
    };

    this.clickHandler = this.clickHandler.bind(this);
  }

  clickHandler(idx) {
    this.setState({selectedPane: idx});
  }

  render() {


    return (
      <section className={"tabs"}>
        <ul>
          <Headers
            panes={this.props.panes}
            onTabChosen ={this.clickHandler}
            selectedPane={this.state.selectedPane}
            />
        </ul>
        <article>
          {this.props.panes[this.state.selectedPane].content}
        </article>
      </section>
    );
  }
}

class Headers extends React.Component {
  render() {
    const tabs = this.props.panes.map((data, idx) => {
      return (
        <li
          key={idx}
          className={idx === this.props.selectedPane ? "active" : ""}
          onClick={this.props.onTabChosen.bind(null, idx)}
        >
        <h1>{data.title}</h1>
      </li>);
    });

    return (<div>{tabs}</div>);
  }
}
