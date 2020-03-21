/* global process */

import React from 'react';
import ReactDOM from 'react-dom';

import Result from './result';
import { cleanURL, Search, updateURL } from './search';

import logo from './img/logo.jpg';

import '../node_modules/materialize-css/dist/css/materialize.min.css';

import './css/style.css';

class App extends React.Component {
  constructor(props) {
    super(props);

    this.handleChange = this.handleChange.bind(this);
    this.handleFocus = this.handleFocus.bind(this);
    this.handleKeyDown = this.handleKeyDown.bind(this);
    this.search = this.search.bind(this);

    this.state = this.cleanState();
  }

  cleanState() {
    let state = {
      checked: false,
      loader: false,
      results: [],
      value: '',
    };
    return state;
  }

  async componentDidMount() {
    let params = new URLSearchParams(window.location.search);
    let query = params.get('q');
    if (query !== null) {
      await this.setState({ value: query });
      this.search();
    }
  }

  async handleChange(event) {
    let value = event.target.value;
    await this.setState({ value });

    if (value.length >= 3) {
      this.search();
    }
  }

  handleFocus() {
    let state = this.cleanState();
    this.setState(state);
    cleanURL();
  }

  handleKeyDown(event) {
    if (event.key == 'Enter' && this.state.value != '') {
      this.search();
    }
  }

  async search() {
    updateURL(this.state.value);

    let url = new URL(`${location.protocol}//${process.env.API_URL}`);
    url.searchParams.append('q', this.state.value);

    this.setState({ loader: true });
    let res = await fetch(url);
    let results = await res.json();
    this.setState({ loader: false });
    let checked = true;

    this.setState({ checked, results });
  }

  render() {
    return (
      <div className="container center">
        <div className="row">
          <img src={logo} className="logo" />
        </div>
        <h1 className="grey-text text-darken-1">Buscador Malvados</h1>
        <Search
          value={this.state.value}
          onChange={this.handleChange}
          onFocus={this.handleFocus}
          onKeyDown={this.handleKeyDown}
        />
        <Result
          checked={this.state.checked}
          items={this.state.results}
          loader={this.state.loader}
        />
      </div>
    );
  }
}

ReactDOM.render(<App />, document.getElementById('root'));
