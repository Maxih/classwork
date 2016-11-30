import {connect} from 'react-redux';
import {fetchPokemonDetail} from '../../actions/pokemon_actions';
import PokemonDetail from './pokemon_detail';

const mapStateToProps = state => ({
  pokemon: state.pokemonDetail
});

const mapDispatchToProps = dispatch => {
  return {fetchPokemonDetail: () => dispatch(fetchPokemonDetail())};
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(PokemonDetail);
