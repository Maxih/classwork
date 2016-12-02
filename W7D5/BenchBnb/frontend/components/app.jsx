import React from 'react';
import GreetingContainer from './greeting/greeting_container';

const App = function({ children }) {
  
  return (
  <div>
    <h1>Bench BnB</h1>
    <GreetingContainer />
    { children }
  </div>
  );
};

export default App;
