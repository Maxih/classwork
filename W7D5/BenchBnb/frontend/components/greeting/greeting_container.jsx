import {connect} from 'react-redux';
import Greeting from './greeting';
import * as Action from '../../actions/session_actions';

const mapStateToProps = state => ({
  session: state.session
});

const mapDispatchToProps = dispatch => ({
  logout: () => dispatch(Action.logout())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Greeting);
