import React from 'react';
import ReactDOM from 'react-dom';
import {Link} from 'react-router';


const Greeting = function({session, logout}) {

  function logOutUser() {
    logout();
  }

  if(session.username) {
    return (
      <section>
        <span>hi {session.username}</span>
        <button onClick={logOutUser}>Logout</button>
      </section>
    );
  } else {
    return (
      <section>
        <Link to="/signup">Sign Up</Link>
        <Link to="/login">Login</Link>
      </section>
    );
  }
};

export default Greeting;
