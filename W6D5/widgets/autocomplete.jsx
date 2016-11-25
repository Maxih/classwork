import React from "react";

class AutoComplete extends React.Component{
  constructor(props) {
    super(props);

    this.state = {
      names: this.props.names,
      input: ""
    };
  }

  inputHandler(e) {
    const input = e.target.value;
    const matchingNamesArr = this.matchingNames(input);


    this.setState({input: input, names: matchingNamesArr});
  }

  matchingNames(name) {
    const matchingNamesArr = [];
    this.props.names.forEach((curName) => {
      if(curName.slice(0, name.length) === name) {
        matchingNamesArr.push(curName);
      }
    });
    return matchingNamesArr;
  }

  clickHandler(name) {
    // const input = e.target.key;
    const matchingNamesArr = this.matchingNames(name);
    this.setState({ input: name, names: matchingNamesArr });
  }

  render() {

    return (
      <section className={"autocomplete"}>
        <input
          type="text"
          value={this.state.input}
          onChange={this.inputHandler.bind(this)}
        />
        <SearchOptions
          onNameClick={this.clickHandler.bind(this)}
          names={this.state.names}
        />
      </section>
    );
  }
}

class SearchOptions extends React.Component {
  render() {
    const names = this.props.names.map((name) => {
      return (
        <li key={name} onClick={this.props.onNameClick.bind(null, name)}>{name}</li>
      );
    });

    return (<ul>{names}</ul>);
  }
}

export default AutoComplete;
