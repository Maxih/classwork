import { combineReducers } from 'redux';
import {PokemonReducer, PokemonDetailReducer} from './pokemon_reducer';

export default combineReducers({
  pokemon: PokemonReducer,
  pokemonDetail: PokemonDetailReducer
});
