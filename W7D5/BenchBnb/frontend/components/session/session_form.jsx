import React from 'react';
import { Link, withRouter } from 'react-router';

class SessionForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        username: "",
        password: ""
    };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.userChange = this.userChange.bind(this);
    this.passChange = this.passChange.bind(this);
    this.redirectIfLoggedIn = this.redirectIfLoggedIn.bind(this);
  }
  handleSubmit(e) {
    e.preventDefault();
    const user = Object.assign({}, this.state);
    this.props.processForm(user).then(() => this.props.router.push("/"));
  }
  componentDidUpdate() {
		this.redirectIfLoggedIn();
	}

  redirectIfLoggedIn() {
    if (this.props.loggedIn) {
      this.props.router.push("/");
    }
  }

  userChange(e) {

    this.setState({username: e.target.value});
  }

  passChange(e) {
    this.setState({password: e.target.value});
  }

  render() {
    return (
      <section>
        <h1>{this.props.formType}</h1>
        <form onSubmit={this.handleSubmit}>
          <input value={this.state.username} type="text" onChange={this.userChange}/>
          <input value={this.state.password} type="password" onChange={this.passChange}/>
          <button>{this.props.formType}</button>
        </form>
      </section>
    );
  }
}

export default SessionForm;
