import React from 'react';
import PokemonIndexItem from './pokemon_index_item';

export default class PokemonIndex extends React.Component {
  componentDidMount() {
    this.props.fetchAllPokemon();
  }

  render() {
    const {pokemon} = this.props;

    const pokemonItems = pokemon.map(poke => {
      return (<PokemonIndexItem key={ poke.id } pokemon={ poke } />);
    });


    return (<section className="pokedex">
      <ul>
        { pokemonItems }
      </ul>
    </section>
    );
  }
}
