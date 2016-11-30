import * as APIUtil from '../util/api_util.js';

export const RECEIVE_ALL_POKEMON = "RECEIVE_ALL_POKEMON";
export const RECEIVE_POKEMON_DETAIL = "RECEIVE_POKEMON_DETAIL";

export const receiveAllPokemon = pokemon => ({
    type: RECEIVE_ALL_POKEMON,
    pokemon: pokemon
});

export const receivePokemonDetail = pokemon => ({
    type: RECEIVE_POKEMON_DETAIL,
    pokemon: pokemon
});


export function fetchAllPokemon() {
  return (dispatch) => {
    APIUtil.fetchAllPokemon().then(pokemon => dispatch(receiveAllPokemon(pokemon)));
  };
}

export function fetchPokemonDetail() {
  return (dispatch) => {
    APIUtil.fetchPokemonDetail().then(pokemon => dispatch(receivePokemonDetail(pokemon)));
  };
}
