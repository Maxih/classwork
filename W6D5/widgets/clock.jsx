import React from "react";
import ReactDOM from "react-dom";

class Clock extends React.Component {
  constructor() {
    super();
    this.state = {time: new Date()};
  }

  componentDidMount() {
    this.interval = setInterval(this.tickClock.bind(this), 1000);
  }

  componentWillUnmount() {
    removeInterval(this.interval);
  }

  tickClock() {
    this.setState({time: new Date()});
  }

  render() {
    return (
    <section className={"clock"}>
      {this.state.time.toTimeString()}
    </section>
  );
  }

}

export default Clock;
