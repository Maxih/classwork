
export const fetchAllPokemon = function(success) {
  return $.ajax({
    method: "GET",
    url: "api/pokemon",
    success
  });
};

export const fetchPokemonDetail = function(pokemon) {
  return $.ajax({
    method: "GET",
    url: `api/pokemon/${pokemon.id}`
  });
};
