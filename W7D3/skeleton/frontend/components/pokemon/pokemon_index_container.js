import {connect} from 'react-redux';
import {fetchAllPokemon} from '../../actions/pokemon_actions';
import {selectAllPokemon} from '../../reducers/selectors';
import PokemonIndex from './pokemon_index';

const mapStateToProps = state => ({
  pokemon: selectAllPokemon(state)
});

const mapDispatchToProps = dispatch => {
  return {fetchAllPokemon: () => dispatch(fetchAllPokemon())};
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(PokemonIndex);
