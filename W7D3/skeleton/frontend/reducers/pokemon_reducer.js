import { merge } from 'lodash';

import {
  RECEIVE_ALL_POKEMON,
  RECEIVE_NEW_POKEMON,
  RECEIVE_POKEMON_DETAIL
} from '../actions/pokemon_actions';

export const PokemonReducer = (state = {}, action) => {
  switch (action.type) {
    case RECEIVE_ALL_POKEMON:
      return merge({}, action.pokemon);
    case RECEIVE_NEW_POKEMON:
      return merge({}, state, {
        [action.pokemon.id]: action.pokemon
      });
    default:
      return state;
  }
};

export const PokemonDetailReducer = (state = {}, action) => {
  switch(action.type) {
    case RECEIVE_POKEMON_DETAIL:
      return action.pokemon;
    default:
      return state;
  }
};
