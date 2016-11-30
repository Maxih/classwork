import React from 'react';
import ReactDOM from 'react-dom';

import { RECEIVE_ALL_POKEMON, receiveAllPokemon, fetchAllPokemon, fetchPokemonDetail } from './actions/pokemon_actions';
import rootReducer from './reducers/root_reducer';
import configureStore from './store/store.js';
import {selectAllPokemon} from './reducers/selectors.js';
import Root from './components/root';

document.addEventListener('DOMContentLoaded', () => {
  const store = configureStore();

  window.store = store;
  window.fetchAllPokemon = fetchAllPokemon;
  window.receiveAllPokemon = receiveAllPokemon;
  window.selectAllPokemon = selectAllPokemon;
  window.fetchPokemonDetail = fetchPokemonDetail;

  const rootEl = document.getElementById('root');
  ReactDOM.render(<Root store={store}/>, rootEl);


});
