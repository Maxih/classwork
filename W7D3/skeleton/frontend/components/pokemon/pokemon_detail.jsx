import React from 'react';

export default class PokemonDetail extends React.Component {
  componentDidMount() {
    this.props.fetchPokemonDetail();
  }

  render() {


    return (
      <li className="pokemon-details">
        {props.pokemon.name}
        <img src={props.pokemon.image_url} />
      </li>
    );
  }
}
