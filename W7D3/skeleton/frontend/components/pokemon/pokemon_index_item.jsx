import React from 'react';
import { Link } from 'react-router';

const PokemonIndexItem = (props) => {

  const handleClick = url => e => props.router.push(url);

  return (
    <li className="pokemon-index-item">
      <Link to={`/pokemon/${props.pokemon.id}`}>
        {props.pokemon.name}
        <img src={props.pokemon.image_url} />
      </Link>
    </li>
  );
};

export default PokemonIndexItem;
